package com.cloud.ratelimit.integration;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import com.cloud.api.response.ApiLimitResponse;
import com.cloud.api.response.SuccessResponse;
import com.cloud.utils.exception.CloudRuntimeException;

import java.util.HashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.junit.Before;
import org.junit.Test;

/**
 * Test fixture to do integration rate limit test.
 * Currently we commented out this test suite since it requires a real MS and Db running.
 */
public class RateLimitIT extends APITest {

    private static final int apiMax = 25;         // assuming ApiRateLimitService set api.throttling.max = 25

    @Before
    public void setup() {
        // always reset count for each testcase
        login("admin", "password");

        // issue reset api limit calls
        final HashMap<String, String> params = new HashMap<>();
        params.put("response", "json");
        params.put("sessionkey", sessionKey);
        final String resetResult = sendRequest("resetApiLimit", params);
        assertNotNull("Reset count failed!", fromSerializedString(resetResult, SuccessResponse.class));
    }

    @Test
    public void testNoApiLimitOnRootAdmin() throws Exception {
        // issue list Accounts calls
        final HashMap<String, String> params = new HashMap<>();
        params.put("response", "json");
        params.put("listAll", "true");
        params.put("sessionkey", sessionKey);
        // assuming ApiRateLimitService set api.throttling.max = 25
        final int clientCount = 26;
        final Runnable[] clients = new Runnable[clientCount];
        final boolean[] isUsable = new boolean[clientCount];

        final CountDownLatch startGate = new CountDownLatch(1);

        final CountDownLatch endGate = new CountDownLatch(clientCount);

        for (int i = 0; i < isUsable.length; ++i) {
            final int j = i;
            clients[j] = new Runnable() {

                /**
                 * {@inheritDoc}
                 */
                @Override
                public void run() {
                    try {
                        startGate.await();

                        sendRequest("listAccounts", params);

                        isUsable[j] = true;
                    } catch (final CloudRuntimeException e) {
                        isUsable[j] = false;
                        e.printStackTrace();
                    } catch (final InterruptedException e) {
                        e.printStackTrace();
                    } finally {
                        endGate.countDown();
                    }
                }
            };
        }

        final ExecutorService executor = Executors.newFixedThreadPool(clientCount);

        for (final Runnable runnable : clients) {
            executor.execute(runnable);
        }

        startGate.countDown();

        endGate.await();

        int rejectCount = 0;
        for (int i = 0; i < isUsable.length; ++i) {
            if (!isUsable[i]) {
                rejectCount++;
            }
        }

        assertEquals("No request should be rejected!", 0, rejectCount);
    }

    @Test
    public void testApiLimitOnUser() throws Exception {
        // log in using normal user
        login("demo", "password");
        // issue list Accounts calls
        final HashMap<String, String> params = new HashMap<>();
        params.put("response", "json");
        params.put("listAll", "true");
        params.put("sessionkey", sessionKey);

        final int clientCount = apiMax + 1;
        final Runnable[] clients = new Runnable[clientCount];
        final boolean[] isUsable = new boolean[clientCount];

        final CountDownLatch startGate = new CountDownLatch(1);

        final CountDownLatch endGate = new CountDownLatch(clientCount);

        for (int i = 0; i < isUsable.length; ++i) {
            final int j = i;
            clients[j] = new Runnable() {

                /**
                 * {@inheritDoc}
                 */
                @Override
                public void run() {
                    try {
                        startGate.await();

                        sendRequest("listAccounts", params);

                        isUsable[j] = true;
                    } catch (final CloudRuntimeException e) {
                        isUsable[j] = false;
                        e.printStackTrace();
                    } catch (final InterruptedException e) {
                        e.printStackTrace();
                    } finally {
                        endGate.countDown();
                    }
                }
            };
        }

        final ExecutorService executor = Executors.newFixedThreadPool(clientCount);

        for (final Runnable runnable : clients) {
            executor.execute(runnable);
        }

        startGate.countDown();

        endGate.await();

        int rejectCount = 0;
        for (int i = 0; i < isUsable.length; ++i) {
            if (!isUsable[i]) {
                rejectCount++;
            }
        }

        assertEquals("Only one request should be rejected!", 1, rejectCount);
    }

    @Test
    public void testGetApiLimitOnUser() throws Exception {
        // log in using normal user
        login("demo", "password");

        // issue an api call
        final HashMap<String, String> params = new HashMap<>();
        params.put("response", "json");
        params.put("listAll", "true");
        params.put("sessionkey", sessionKey);
        sendRequest("listAccounts", params);

        // issue get api limit calls
        final HashMap<String, String> params2 = new HashMap<>();
        params2.put("response", "json");
        params2.put("sessionkey", sessionKey);
        final String getResult = sendRequest("getApiLimit", params2);
        final ApiLimitResponse getLimitResp = (ApiLimitResponse) fromSerializedString(getResult, ApiLimitResponse.class);
        assertEquals("Issued api count is incorrect!", 2, getLimitResp.getApiIssued()); // should be 2 apis issues plus this getlimit api
        assertEquals("Allowed api count is incorrect!", apiMax - 2, getLimitResp.getApiAllowed());
    }
}

package com.cloud.usage;

import com.cloud.api.command.admin.usage.GenerateUsageRecordsCmd;
import com.cloud.api.command.admin.usage.GetUsageRecordsCmd;
import com.cloud.api.command.admin.usage.RemoveRawUsageRecordsCmd;
import com.cloud.api.response.UsageTypeResponse;
import com.cloud.utils.Pair;

import java.util.List;
import java.util.TimeZone;

public interface UsageService {
    /**
     * Generate Billing Records from the last time it was generated to the
     * time specified.
     *
     * @param cmd the command wrapping the generate parameters
     *            - userId unique id of the user, pass in -1 to generate billing records
     *            for all users
     *            - startDate
     *            - endDate inclusive.  If date specified is greater than the current time, the
     *            system will use the current time.
     */
    boolean generateUsageRecords(GenerateUsageRecordsCmd cmd);

    /**
     * Retrieves all Usage Records generated between the start and end date specified
     *
     * @param userId    unique id of the user, pass in -1 to retrieve billing records
     *                  for all users
     * @param startDate inclusive.
     * @param endDate   inclusive.  If date specified is greater than the current time, the
     *                  system will use the current time.
     * @param page      The page of usage records to see (500 results are returned at a time, if
     *                  more than 500 records exist then additional results can be retrieved by
     *                  the appropriate page number)
     * @return a list of usage records
     */
    Pair<List<? extends Usage>, Integer> getUsageRecords(GetUsageRecordsCmd cmd);

    /**
     * Retrieves the timezone used for usage aggregation.  One day is represented as midnight to 11:59:59pm
     * in the given time zone
     *
     * @return the timezone specified by the config value usage.aggregation.timezone, or GMT if null
     */
    TimeZone getUsageTimezone();

    boolean removeRawUsageRecords(RemoveRawUsageRecordsCmd cmd);

    List<UsageTypeResponse> listUsageTypes();
}

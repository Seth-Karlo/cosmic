package com.cloud.api.query.dao;

import com.cloud.api.query.vo.UserAccountJoinVO;
import com.cloud.api.response.UserResponse;
import com.cloud.user.User;
import com.cloud.user.UserAccount;
import com.cloud.utils.db.GenericDaoBase;
import com.cloud.utils.db.SearchBuilder;
import com.cloud.utils.db.SearchCriteria;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class UserAccountJoinDaoImpl extends GenericDaoBase<UserAccountJoinVO, Long> implements UserAccountJoinDao {
    public static final Logger s_logger = LoggerFactory.getLogger(UserAccountJoinDaoImpl.class);

    private final SearchBuilder<UserAccountJoinVO> vrIdSearch;

    private final SearchBuilder<UserAccountJoinVO> vrAcctIdSearch;

    protected UserAccountJoinDaoImpl() {

        vrIdSearch = createSearchBuilder();
        vrIdSearch.and("id", vrIdSearch.entity().getId(), SearchCriteria.Op.EQ);
        vrIdSearch.done();

        vrAcctIdSearch = createSearchBuilder();
        vrAcctIdSearch.and("accountId", vrAcctIdSearch.entity().getAccountId(), SearchCriteria.Op.EQ);
        vrAcctIdSearch.done();

        this._count = "select count(distinct id) from user_view WHERE ";
    }

    @Override
    public UserResponse newUserResponse(final UserAccountJoinVO usr) {
        final UserResponse userResponse = new UserResponse();
        userResponse.setAccountId(usr.getAccountUuid());
        userResponse.setAccountName(usr.getAccountName());
        userResponse.setAccountType(usr.getAccountType());
        userResponse.setCreated(usr.getCreated());
        userResponse.setDomainId(usr.getDomainUuid());
        userResponse.setDomainName(usr.getDomainName());
        userResponse.setEmail(usr.getEmail());
        userResponse.setFirstname(usr.getFirstname());
        userResponse.setId(usr.getUuid());
        userResponse.setLastname(usr.getLastname());
        userResponse.setState(usr.getState().toString());
        userResponse.setTimezone(usr.getTimezone());
        userResponse.setUsername(usr.getUsername());
        userResponse.setApiKey(usr.getApiKey());
        userResponse.setSecretKey(usr.getSecretKey());
        userResponse.setIsDefault(usr.isDefault());

        // set async job
        if (usr.getJobId() != null) {
            userResponse.setJobId(usr.getJobUuid());
            userResponse.setJobStatus(usr.getJobStatus());
        }

        userResponse.setObjectName("user");

        return userResponse;
    }

    @Override
    public UserAccountJoinVO newUserView(final User usr) {
        final SearchCriteria<UserAccountJoinVO> sc = vrIdSearch.create();
        sc.setParameters("id", usr.getId());
        final List<UserAccountJoinVO> users = searchIncludingRemoved(sc, null, null, false);
        assert users != null && users.size() == 1 : "No user found for user id " + usr.getId();
        return users.get(0);
    }

    @Override
    public UserAccountJoinVO newUserView(final UserAccount usr) {
        final SearchCriteria<UserAccountJoinVO> sc = vrIdSearch.create();
        sc.setParameters("id", usr.getId());
        final List<UserAccountJoinVO> users = searchIncludingRemoved(sc, null, null, false);
        assert users != null && users.size() == 1 : "No user found for user id " + usr.getId();
        return users.get(0);
    }

    @Override
    public List<UserAccountJoinVO> searchByAccountId(final Long accountId) {
        final SearchCriteria<UserAccountJoinVO> sc = vrAcctIdSearch.create();
        sc.setParameters("accountId", accountId);
        return search(sc, null, null, false);
    }
}

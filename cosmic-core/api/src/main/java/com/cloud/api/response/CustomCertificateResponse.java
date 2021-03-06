package com.cloud.api.response;

import com.cloud.api.BaseResponse;
import com.cloud.serializer.Param;

import com.google.gson.annotations.SerializedName;

public class CustomCertificateResponse extends BaseResponse {

    @SerializedName("message")
    @Param(description = "message of the certificate upload operation")
    private String message;

    public String getResultMessage() {
        return message;
    }

    public void setResultMessage(final String msg) {
        this.message = msg;
    }
}

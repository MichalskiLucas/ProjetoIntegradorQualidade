package br.integration.cookmasterapi.exception;

import java.util.Arrays;
import java.util.List;

public class ApiErrorMessage {

    private List<String> errors;

    public ApiErrorMessage(List<String> errors) {
        this.errors = errors;
    }

    public ApiErrorMessage(String error) {
        this.errors = Arrays.asList(error);
    }

    public List<String> getErrors() {
        return errors;
    }

    public void setErrors(List<String> errors) {
        this.errors = errors;
    }



}

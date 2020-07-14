package online.luffyk.utils;

public class Result {
    private String message;
    private Object data;
    private Integer code;

    public Result() {
    }

    public Result(String message, Object data, Integer code) {
        this.message = message;
        this.data = data;
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    @Override
    public String toString() {
        return "Result{" +
                "message='" + message + '\'' +
                ", data=" + data +
                ", code=" + code +
                '}';
    }
}

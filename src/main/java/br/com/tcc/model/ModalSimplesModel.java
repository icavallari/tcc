package br.com.tcc.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ModalSimplesModel {

    private String min;
    private String med;
    private String max;
    private Date   data;

    public String getMin() {
        return min;
    }

    public void setMin(String min) {
        this.min = min;
    }

    public String getMed() {
        return med;
    }

    public void setMed(String med) {
        this.med = med;
    }

    public String getMax() {
        return max;
    }

    public void setMax(String max) {
        this.max = max;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public String getDataString() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM - HH");
        return sdf.format(data) + " hrs";
    }

}

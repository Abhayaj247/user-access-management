package com.uams.model;

import java.util.Arrays;
import java.util.List;

public class Software {
    private int id;
    private String name;
    private String description;
    private List<String> accessLevels;

    public Software() {}

    public Software(String name, String description, String... accessLevels) {
        this.name = name;
        this.description = description;
        this.accessLevels = Arrays.asList(accessLevels);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getAccessLevels() {
        return accessLevels;
    }

    public void setAccessLevels(List<String> accessLevels) {
        this.accessLevels = accessLevels;
    }

    public void setAccessLevels(String... accessLevels) {
        this.accessLevels = Arrays.asList(accessLevels);
    }
}

package net.example.domain;

import java.io.Serializable;

public class Customer implements Serializable {

    // TODO: introduce properties which will require a custom formatter

    private Long id;
    private String forename, surname;
    private Integer age;

    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", forename='" + forename + '\'' +
                ", surname='" + surname + '\'' +
                ", age=" + age +
                '}';
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        // Not required in a real-life application, where id generation and assignment done via persistence manager.
        this.id = id;
    }

    public String getForename() {
        return forename;
    }

    public void setForename(String forename) {
        this.forename = forename;
    }
    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }
}

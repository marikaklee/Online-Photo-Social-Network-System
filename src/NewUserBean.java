package photoshare;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


public class NewUserBean {
  private String email = "";
  private String password1 = "";
  private String password2 = "";
  private String first = "";
  private String last = "";
  private String gender = "";
  private String birthdate = "";

  public String saySomething() {
    System.out.println("Hello!");
    return "Test";
  }
  
  public String getEmail() {
    return email;
  }

  public String getPassword1() {
    return password1;
  }

  public String getPassword2() {
    return password2;
  }

  public String getFirst(){
    return first;
  }
  
  public String getLast(){
    return last;
  }

  public String getGender(){
    return gender;
  }
  
  public String getBirthdate(){
    return birthdate;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public void setPassword1(String password1) {
    this.password1 = password1;
  }

  public void setPassword2(String password2) {
    this.password2 = password2;
  }

  public void setFirst(String first){
    this.first = first;
  }
  
  public void setLast(String last){
    this.last = last;
  }

  public void setGender(String gender){
    this.gender = gender;
  }
  public void setBirthdate(String birthdate){
    this.birthdate = birthdate;
  }
}
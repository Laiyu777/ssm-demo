package Test;


import util.Utils;

import java.util.List;

/**
 * Created by Administrator on 2017/12/6.
 */
public class MAIN {
    public static void main(String[] args) {
      A a = new A();
      B b = new B();
      C c= new C();

      a.callB(b);

    }
}
class A{
    public void callB(B b){
        System.out.println(b);
        b.setName("小明");
        C c = new C();
        b.setName("小白");
        c.cCallB(b);
    }
}


class B {
   private String name;

    @Override
    public String toString() {
        return "B{" +
                "name='" + name + '\'' +
                '}';
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

class C{
    public void cCallB(B b){
        System.out.println(b);
    }
}

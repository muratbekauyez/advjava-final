package tools;

public class MyThread {
    int id;
    String title;
    String content;
    String status;

    public MyThread(int id, String title, String content, String status) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.status = status;
    }

    public MyThread(String[] threadFields) {
        if (threadFields.length == 4){
            this.id = Integer.parseInt(threadFields[0]);
            this.title = threadFields[1];
            this.content = threadFields[2];
            this.status = threadFields[3];
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

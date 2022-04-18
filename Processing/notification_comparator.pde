import java.util.Comparator;

public class NotificationComparator implements Comparator<Notification> {

    public int compare(Notification i1, Notification i2) {
        return min(i1.getPriority(), i2.getPriority());
    }
}

import java.util.Comparator;

public class InstanceComparator implements Comparator<Instance> {

    public int compare(Instance i1, Instance i2) {
        return min(i1.getPriorityLevel(), i2.getPriorityLevel());
    }
}
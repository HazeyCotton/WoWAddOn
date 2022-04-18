import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

class InstanceServer {

    Boolean debugMode = true;

    Timer timer;
    Calendar calendar;
    private ArrayList<InstanceListener> listeners;
    private ArrayList<Instance> currentInstances;
    long startTime;
    long pauseTime;

    public InstanceServer() {
        timer = new Timer();
        listeners = new ArrayList<InstanceListener>();
        calendar = Calendar.getInstance();
    }

    public void loadEventStream(String eventDataJSON) {
        currentInstances = this.getInstanceDataFromJSON(loadJSONArray(eventDataJSON));

        Date date = new Date();
        startTime = date.getTime();
        println("startTime = ", startTime);

        for (int i = 0; i < currentInstances.size(); i++) {
            this.scheduleTask(currentInstances.get(i));
        }
    }

    public void stopEventStream() {
        pauseTime = 0;
        this.stopTimer();
    }

    public void pauseEventStream() {
        Date date = new Date();
        pauseTime = date.getTime() - startTime;
        this.stopTimer();
    }

    public void stopTimer() {
        if (timer != null) 
            timer.cancel();
        timer = new Timer();
    }

    public ArrayList<Instance> getCurrentInstances() {
        return currentInstances;
    }

    public ArrayList<Instance> getInstanceDataFromJSON(JSONArray values) {
        ArrayList<Instance> instances = new ArrayList<Instance>();
        for (int i = 0; i < values.size(); i++) {
            println(values.getJSONObject(i));
            instances.add(new Instance(values.getJSONObject(i)));
        }
        return instances;
    }

    public void scheduleTask(Instance instance) {
        if (instance.getTimestamp() >= pauseTime) {
            timer.schedule(new InstanceTask(this, instance), instance.getTimestamp() - pauseTime);
        }
    }

    public void addListener(InstanceListener listenerToAdd) {
        listeners.add(listenerToAdd);
    }

    public void notifyListeners(Instance instance) {
        if (debugMode)
            println("<InstanceServer> " + instance.toString());
        for (int i=0; i < listeners.size(); i++) {
            listeners.get(i).instanceRecieved(instance);
        }
    }

    class InstanceTask extends TimerTask {
        InstanceServer server;
        Instance instance;

        public InstanceTask(InstanceServer server, Instance instance) {
            super();
            this.server = server;
            this.instance = instance;
        }

        public void run() {
            server.notifyListeners(instance);
        }
    }
}
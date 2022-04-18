import beads.*;
import org.jaudiolibs.beads.*;
import controlP5.*;

  ControlP5 p5;
  Button startEventStream;
  Button pauseEventStream;
  Button stopEventStream;

  TextToSpeechMaker ttsMaker; 

  SamplePlayer trinketPlayer = null;
  SamplePlayer debuffPlayer = null;
  BiquadFilter trinketFilter;
  BiquadFilter debuffFilter;

  String eventDataJSON3 = "TrinketCooldown.json";
  String eventDataJSON2 = "HealthStatus.json";
  String eventDataJSON1 = "DebuffStatus.json";

  NotificationServer notificationServer;
  ArrayList<Notification> notifications;

  MyNotificationListener myNotificationListener;

  Gain masterGain;
  Glide gainGlide;
  SamplePlayer healthPlayer = null;
  BiquadFilter healthFilter;

  void setup() {
    size(280,200);
    p5 = new ControlP5(this);
  
    ac = new AudioContext(); //ac is defined in helper_functions.pde
  
    gainGlide = new Glide(ac, 1.0, 500);
    masterGain = new Gain(ac, 1, gainGlide);
  
    healthPlayer = getSamplePlayer("HealthNoise.wav");
    healthPlayer.pause(true);
  
    healthFilter = new BiquadFilter(ac, BiquadFilter.AP, 1000.0, 0.5f);
    healthFilter.addInput(healthPlayer);
     
    trinketPlayer = getSamplePlayer("TrinketNoise.wav");
    trinketPlayer.pause(true);
    debuffPlayer = getSamplePlayer("DebuffNoise.wav");
    debuffPlayer.pause(true);
     
    trinketFilter = new BiquadFilter(ac, BiquadFilter.AP, 1000.0, 0.5f);
    debuffFilter = new BiquadFilter(ac, BiquadFilter.AP, 1000.0, 0.5f);
    trinketFilter.addInput(trinketPlayer);
    debuffFilter.addInput(debuffPlayer);
     
    masterGain.addInput(trinketFilter);
    masterGain.addInput(debuffFilter);
    masterGain.addInput(healthFilter);
  
    ac.out.addInput(masterGain);

    ttsMaker = new TextToSpeechMaker();
  
    notificationServer = new NotificationServer();
  
    myNotificationListener = new MyNotificationListener();
    notificationServer.addListener(myNotificationListener);
    
    startEventStream = p5.addButton("startEventStream")
      .setPosition(0,15)
      .setSize(100,20)
      .setLabel("Start Event Stream");
    
    startEventStream = p5.addButton("pauseEventStream")
      .setPosition(0,40)
      .setSize(100,20)
      .setLabel("Pause Event Stream");
 
    startEventStream = p5.addButton("stopEventStream")
      .setPosition(0,65)
      .setSize(100,20)
      .setLabel("Stop Event Stream");
    
    p5.addSlider("GainSlider")
      .setPosition(10, 120)
      .setSize(120, 20)
      .setRange(0, 100)
      .setValue(50)
      .setLabel("Gain");
    
    Button playHealth = p5.addButton("playHealth")
     .setPosition(200, 10)
     .setSize(60, 50)
     .activateBy((ControlP5.RELEASE))
     .setLabel("Health Alert");
    
    Button playTrinket = p5.addButton("playTrinket")
      .setPosition(200, 80)
      .setSize(60, 50)
      .activateBy((ControlP5.RELEASE))
      .setLabel("Trinket Alert");
    
    Button playDebuff = p5.addButton("playDebuff")
      .setPosition(200, 150)
      .setSize(60, 50)
      .activateBy((ControlP5.RELEASE))
      .setLabel("Debuff Alert");
      
    p5.addButton("priorityOne")
      .setPosition(20, 180)
      .setSize(20, 20)
      .activateBy((ControlP5.RELEASE))
      .setLabel("1");
      
    p5.addButton("priorityTwo")
      .setPosition(45, 180)
      .setSize(20, 20)
      .activateBy((ControlP5.RELEASE))
      .setLabel("2");
    
    p5.addButton("priorityThree")
      .setPosition(70, 180)
      .setSize(20, 20)
      .activateBy((ControlP5.RELEASE))
      .setLabel("3");
     
     ac.start();
  }

  void startEventStream(int value) {
    //loading the event stream, which also starts the timer serving events
    notificationServer.loadEventStream(eventDataJSON1);
  }

  void pauseEventStream(int value) {
    //loading the event stream, which also starts the timer serving events
    notificationServer.pauseEventStream();
  }

  void stopEventStream(int value) {
    //loading the event stream, which also starts the timer serving events
    notificationServer.stopEventStream();
  }
  
  void GainSlider(float value) {
    gainGlide.setValue(value/100.0);
  }

  void playHealth() {
    healthPlayer.start(0.0);
  }
  
  void playTrinket() {
    trinketPlayer.start(0.0);
  }
  
  void playDebuff() {
    debuffPlayer.start(0.0);
  }
  
  void priorityOne() {
    healthFilter.setType(BiquadFilter.LP);
    trinketFilter.setType(BiquadFilter.LP);
    debuffFilter.setType(BiquadFilter.LP);
  }
  
  void priorityTwo() {
    healthFilter.setType(BiquadFilter.HP);
    trinketFilter.setType(BiquadFilter.HP);
    debuffFilter.setType(BiquadFilter.HP);
  }
  
  void priorityThree() {
    healthFilter.setType(BiquadFilter.AP);
    trinketFilter.setType(BiquadFilter.AP);
    debuffFilter.setType(BiquadFilter.AP);
  }

void draw() {
  //this method must be present (even if empty) to process events such as keyPressed()  
  background(color(75, 0, 130));
}

void keyPressed() {
  //example of stopping the current event stream and loading the second one
  if (key == TAB) {
    notificationServer.stopEventStream(); //always call this before loading a new stream
    notificationServer.loadEventStream(eventDataJSON2);
    println("**** New event stream loaded: " + eventDataJSON2 + "   ****");
  } else if (key == BACKSPACE) {
    notificationServer.stopEventStream();
    notificationServer.loadEventStream(eventDataJSON3);
    println("**** New event stream loaded: " + eventDataJSON3 + " ****");
  } else if (key == ENTER) {
    notificationServer.stopEventStream();
    notificationServer.loadEventStream(eventDataJSON1);
    println("**** New event stream loaded: " + eventDataJSON1 + " ****");
  }
    
}

//in your own custom class, you will implement the NotificationListener interface 
//(with the notificationReceived() method) to receive Notification events as they come in
class MyNotificationListener implements NotificationListener {
  
  public MyNotificationListener() {
    
  }
  
  BiquadFilter filter;
  Gain g;
  
  //this method must be implemented to receive notifications
  public void notificationReceived(Notification notification) {  
    println("<Example> " + notification.getType().toString() + " instance received at " 
    + Integer.toString(notification.getTimestamp()) + " ms");
    
    SamplePlayer sp = null;
    filter = new BiquadFilter(ac, BiquadFilter.AP, 1000.0, 0.5f); 
    g = new Gain(ac, 1, 1.0);
    
    String debugOutput = ">>> ";
    switch (notification.getType()) {
      case Health:
        debugOutput += "Health changed: ";
        break;
      case Trinket:
        debugOutput += "Trinket changed: ";
        sp = getSamplePlayer("TrinketNoise.wav", true);
        break;
      case Debuff:
        debugOutput += "Debuff changed: ";
        sp = getSamplePlayer("DebuffNoise.wav", true);
        break;
    }
    debugOutput += notification.toString();
    
    println(debugOutput);
 
    String type = notification.getType().toString();
    int priority = notification.getPriority();
    
    if (type == "Health") {
      int health = notification.getHealth();
      sp = getSamplePlayer("HealthNoise.wav", true);
      if (health < 500) {
        filter.setType(BiquadFilter.AP);
        ttsExamplePlayback("Run away!", 3.0);
      } else if (health < 1000) {
        filter.setType(BiquadFilter.HP);
      } else {
        filter.setType(BiquadFilter.LP);
      }
    } else if (type == "Trinket") {
      int cooldown = notification.getCooldown();
      sp = getSamplePlayer("TrinketNoise.wav", true);
      if (cooldown > 60) {
        filter.setType(BiquadFilter.LP);
        g.setGain(0.25);
      } else if (cooldown > 30) {
        filter.setType(BiquadFilter.HP);
        g.setGain(0.5);
      } else {
        filter.setType(BiquadFilter.AP);
        g.setGain(1.0);
      }
    } else if (type == "Debuff") {
      int expiration = notification.getExpiration();
      int duration = notification.getDurationDebuff();
      float reference = expiration / duration;
      String name = notification.getName();
      if (priority == 1) {
        g.setGain(1.0);
      } else if (priority == 2) {
        g.setGain(0.5);
        ttsExamplePlayback(name, 1.0);
      } else {
        g.setGain(0.25);
      }
      
      if (reference > 0.5) {
        filter.setType(BiquadFilter.LP);
      } else if (reference > 0.25) {
        filter.setType(BiquadFilter.HP);
      } else {
        filter.setType(BiquadFilter.AP);
      }
      
    }
    filter.addInput(sp);
    g.addInput(filter);
    ac.out.addInput(g);
    sp.setToLoopStart();
    sp.start();
   }
}

Gain g;
void ttsExamplePlayback(String inputSpeech, float g) {
  
  String ttsFilePath = ttsMaker.createTTSWavFile(inputSpeech);
  println("File created at " + ttsFilePath);

  SamplePlayer sp = getSamplePlayer(ttsFilePath, true); 
  Gain mg = new Gain(ac, 1, g);
  mg.addInput(sp);
  ac.out.addInput(mg);
  sp.setToLoopStart();
  sp.start();
  println("TTS: " + inputSpeech);
}

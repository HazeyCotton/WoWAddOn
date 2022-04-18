enum NotificationType { Health, Debuff, Trinket }

class Notification {
    
    //Type is only used to help not process non used variables
    NotificationType type;
    //Used for event handling (scheduling and stuffffff)
    int timestamp;
    //Used for deciding the intensity of the event
    int priority;
    //Health Data
    int health;
    int maxHealth;
    //Debuff Data
    String name;
    int durationD;
    int expiration;
    //Trinket Data
    int start;
    int cooldown;
    int durationT;


    public Notification(JSONObject json) {
        this.timestamp = json.getInt("timestamp");
        String typeString = json.getString("type");

        try {
            this.type = NotificationType.valueOf(typeString);
        } 
        catch (IllegalArgumentException e) {
            throw new RuntimeException(typeString + "is not a valid value for enum InstanceType");
        }

        //Checks type and only uses pertenient information
        //health and maxhealth
        if (json.isNull("health")) {
          this.health = 0;
          print("null");
        } else {
          this.health = json.getInt("health");
        }

        if (json.isNull("maxHealth")) {
          this.maxHealth = 0;
        } else {
          this.maxHealth = json.getInt("maxHealth");
        }
        //name, durationD (debuff), and expiration
        if (json.isNull("name")) {
          this.name = "";
        } else {
          this.name = json.getString("name");
        }
        if (json.isNull("duration")) {
          this.durationD = 0;
        } else {
          this.durationD = json.getInt("duration");
        }
        if (json.isNull("expiration")) {
          this.expiration = 0;
        } else {
          this.expiration = json.getInt("expiration");
        }
        //start, cooldown, and durationT (trinket)
        if (json.isNull("start")) {
          this.start = 0;
        } else {
          this.start = json.getInt("start");
        }
        if (json.isNull("cooldown")) {
          this.cooldown = 0;
        } else {
          this.cooldown = json.getInt("cooldown");
        }
        if (json.isNull("duration")) {
          this.durationD = 0;
        } else {
          this.durationD = json.getInt("duration");
        }

        this.priority = json.getInt("priority");
    }

    public NotificationType getType() {return type;}
    public int getHealth() {return health;}
    public int getMaxHealth() {return maxHealth;}
    public String getName() {return name;}
    public int getDurationDebuff() {return durationD;}
    public int getExpiration() {return expiration;}
    public int getStart() {return start;}
    public int getCooldown() {return cooldown;}
    public int getDurationTrinket() {return durationT;}
    public int getTimestamp() {return timestamp;}
    public int getPriority() {return priority;}

    public String toString() {
        String output = "";
        String typeString = this.type.toString();
        if (typeString == "Health") {
            output = "(Health: " + getHealth() + ", MaxHealth: " + getMaxHealth() + ")";
        } else if (typeString == "Trinket") {
            output = "(Start: " + getStart() + ", Cooldown: " + getCooldown() + ", Duration: " + getDurationDebuff() + ")";
        } else if (typeString == "Debuff") {
            output = "(Name: " + getName() + ", Duration: " + getDurationDebuff() + ", Expiration: " + getExpiration() + ")";
        } else {
            output = "Empty JSON given";
        }
        return output;
    }
}

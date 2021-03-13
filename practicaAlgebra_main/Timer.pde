<<<<<<< HEAD
class Timer {
  int startTime;
  int interval;
  
  Timer(int timeInterval) {
   interval = timeInterval; 
  }
  
  void start(){
   startTime = millis(); 
  }
  
  boolean complete(){
   int elapsedTime = millis() - startTime;
   if (elapsedTime > interval) {
     return true;
  }else {
    return false;
  }
  }
}
=======
class Timer {
  int startTime;
  int interval;
  
  Timer(int timeInterval) {
   interval = timeInterval; 
  }
  
  void start(){
   startTime = millis(); 
  }
  
  boolean complete(){
   int elapsedTime = millis() - startTime;
   if (elapsedTime > interval) {
     return true;
  }else {
    return false;
  }
  }
}
>>>>>>> 531eebde85645fa44a7820dd23eb9470e8a308d6

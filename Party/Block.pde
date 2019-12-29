class Block{
  PVector center;
  boolean isUpdated = false;
  int mNoiseSeed = (int)random(1000);
  
  Block(int i){
    center = new PVector();
    center.x = maxWidth*(i+0.5); //<>// //<>//
    center.y = height/2;
  }
  
  void display(){
    for (int i = 0; i <nLines; i++){
      fill(colors[i]);
      //noiseSeed(mNoiseSeed);
      noiseSeed(1);
      float a = constrain(noise(0.05*frameCount,0.1*center.x), 0, 0.6);
      //noiseSeed(0);
      float var = maxLineVar * (noise(10*i, center.x, 0.05*frameCount)-0.25);
      rect(center.x, center.y, a*maxWidth*heightFactors[i]*pulseHeight*3 + var, a*maxWidth*heightFactors[i]*pulseHeight*3 + var);
    }
  }
}

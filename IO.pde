/* Keyboard commands
    
    Enter - save a snapshot of the screen
    Left arrow - 
    Right arrow - 
    Up arrow - 
    Down arrow - 
    B - start to bloom
    D - show points
    P - pause the bloom
    T - show trails
    R - record the bloom
    M - show the mouse
    
*/
void keyPressed() {
  if (keyCode == KeyEvent.VK_B) {
    bloom();
  } else if (keyCode == KeyEvent.VK_D) {
    showPoints = !showPoints;
  } else if (keyCode == KeyEvent.VK_P) {
    paused = !paused;
  } else if (keyCode == KeyEvent.VK_T) {
    showTrails = !showTrails;
  } else if (keyCode == KeyEvent.VK_ENTER) {
    saveFrame("snapshots/snapshot-####.png");
  } else if (keyCode == KeyEvent.VK_R) {
    recording = !recording;
  } else if (keyCode == KeyEvent.VK_M) {
    showMouse = !showMouse;
  } else if (keyCode == KeyEvent.VK_I) {
    showArtInfo = !showArtInfo;
  }    
}


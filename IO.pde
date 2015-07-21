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
  } else if (keyCode == KeyEvent.VK_H) {
    setHomeAsOrigin = !setHomeAsOrigin;
  } else if (keyCode == KeyEvent.VK_ENTER) {
    saveFrame("snapshots/snapshot-####.png");
  } else if (keyCode == KeyEvent.VK_R) {
    recording = !recording;
  } else if (keyCode == KeyEvent.VK_M) {
    showMouse = !showMouse;
  } else if (keyCode == KeyEvent.VK_I) {
    showArtInfo = !showArtInfo;
  }  else if (keyCode == KeyEvent.VK_F) {
    showFloors = !showFloors;
  } else if (keyCode == KeyEvent.VK_L) {
    layout = layout.equals("floor") ? "room" : "floor";
    arrangeGalleries();
  } else if (keyCode == KeyEvent.VK_UP) {
    selectedGalleryIndex++;
    if (selectedGalleryIndex >= galleries.size()) {
      selectedGalleryIndex = galleries.size() -1;
     }
    selectedGallery = galleries.get(selectedGalleryIndex);
  } else if (keyCode == KeyEvent.VK_DOWN) {
    selectedGalleryIndex--;
    if (selectedGalleryIndex < 0) {
        selectedGalleryIndex = 0;
    }
    selectedGallery = galleries.get(selectedGalleryIndex);
  } else if (keyCode == KeyEvent.VK_LEFT) {
    selectedClassificationIndex++;
    if (selectedClassificationIndex >= classifications.size()) {
      selectedClassificationIndex = classifications.size() -1;
     }
    selectedClassification = classifications.get(selectedClassificationIndex);
  } else if (keyCode == KeyEvent.VK_RIGHT) {
    selectedClassificationIndex--;
    if (selectedClassificationIndex < 0) {
        selectedClassificationIndex = 0;
    }
    selectedClassification = classifications.get(selectedClassificationIndex);
  }
}

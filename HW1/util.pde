public void CGLine(float x1,float y1,float x2,float y2, color applyColor){
    //To-Do: You need to implement the "line algorithm" in this section. 
    //You can use the function line(x1, y1, x2, y2); to verify the correct answer. 
    //However, remember to comment out the function before you submit your homework. 
    //Otherwise, you will receive a score of 0 for this part.
       
    //Utilize the function drawPoint(x, y, color) to apply color to the pixel at coordinates (x, y).
    //For instance: drawPoint(0, 0, color(255, 0, 0)); signifies drawing a red point at (0, 0).   
       
    
   //stroke(0);
   // noFill();
   //line(x1,y1,x2,y2);
   
   // trandition 
   /*
      int flag;
      if(x1 == x2){
        flag = 0;
      }
      else if(y1 == y2){
        flag = 1;
      }
      else if(x1 < x2 && y1 != y2){
        flag = 2;
      }
      else{
        flag = 3;
      }
      
      float m , bias, x, y;
      switch(flag){
        case 0:
          if(y1 > y2){
            while(y1 != y2){
              drawPoint(x1, y1, color(255, 0, 0));
              y1 -= 1;
            }
          }else{
          while(y1 != y2){
              drawPoint(x1, y1, color(255, 0, 0));
              y1 += 1;
            }
          }
          break;
        case 1:
        if(x1 > x2){
            while(x1 != x2){
              drawPoint(x1, y1, color(255, 0, 0));
              x1 -= 1;
            }
          }else{
          while(x1 != x2){
              drawPoint(x1, y1, color(255, 0, 0));
              x1 += 1;
            }
          }
          break;
        case 2:
        m = (y2 - y1) / (x2 - x1);
        bias = y1  - m * x1;
        y = y1;
        x = x1;
        while(x != x2){
          drawPoint(x, y, color(255, 0, 0));
          x = x + 1;
          y = x * m + bias;
        }
          break;
        case 3:
        m = (y2 - y1) / (x2 - x1);
        bias = y1  - m * x1;
        y = y1;
        x = x1;
        while(x != x2){
          drawPoint(x, y, color(255, 0, 0));
          x = x - 1;
          y = x * m + bias;
        }
          break;
        default:
          break;
      }
      */
      
      //Bresenham
      
      float dx = Math.abs(x2 - x1);
      float dy = Math.abs(y2 - y1);
      float sx = (x1 < x2) ? 1 : -1;
      float sy = (y1 < y2) ? 1 : -1;
      float p = dx - dy;
      float p2;
      while(!(x1 == x2 && y1 == y2)){
        
        drawPoint(x1, y1, applyColor);
        p2 = 2 * p;
        if (p2 > -dy) {
                p = p - dy;
                x1 = x1 + sx;
            }
            if (p2 < dx) {
                p = p + dx;
                y1 = y1 + sy;
            }
      }
}


public void CGCircle(float x,float y,float r, color applyColor){
    //To-Do: You need to implement the "circle algorithm" in this section. 
    //You can use the function circle(x, y, r); to verify the correct answer. 
    //However, remember to comment out the function before you submit your homework. 
    //Otherwise, you will receive a score of 0 for this part.
       
    //Utilize the function drawPoint(x, y, color) to apply color to the pixel at coordinates (x, y).
    //For instance: drawPoint(0, 0, color(255, 0, 0)); signifies drawing a red point at (0, 0).         
    
    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */  
    for(float i = -r; i<= r ; i += 0.018){
       float j =(float) Math.sqrt(r * r - i * i);
       drawPoint(x + i, y + j, applyColor);
       drawPoint(x + i, y - j, applyColor);
    }
}

public void CGEllipse(float x,float y,float r1,float r2, color applyColor){
    //To-Do: You need to implement the "ellipse algorithm" in this section. 
    //You can use the function ellipse(x, y, r1,r2); to verify the correct answer. 
    //However, remember to comment out the function before you submit your homework. 
    //Otherwise, you will receive a score of 0 for this part.
       
    //Utilize the function drawPoint(x, y, color) to apply color to the pixel at coordinates (x, y).
    //For instance: drawPoint(0, 0, color(255, 0, 0)); signifies drawing a red point at (0, 0).         
      
    /*  
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */
   for (float t = 0; t < 2 * Math.PI; t += 0.001) {
            float x_b = (float) (r1 * Math.cos(t));
            float y_b = (float) (r2 * Math.sin(t));
            drawPoint(x + x_b, y + y_b, applyColor);
        }
}

public void CGCurve(Vector3 p1,Vector3 p2,Vector3 p3,Vector3 p4, color applyColor){
    //To-Do: You need to implement the "bezier curve algorithm" in this section. 
    //You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y); to verify the correct answer. 
    //However, remember to comment out the function before you submit your homework. 
    //Otherwise, you will receive a score of 0 for this part.
       
    //Utilize the function drawPoint(x, y, color) to apply color to the pixel at coordinates (x, y).
    //For instance: drawPoint(0, 0, color(255, 0, 0)); signifies drawing a red point at (0, 0). 
    
    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
    // control point  p2 , p3 
    // start p1 
    // end p4
    for (float i = 0; i <= 1; i += 0.001) {
          float j = 1 - i;
          float x = j * j * j * p1.x + 3 * j * j * i * p2.x + 3 * j * i * i * p3.x + i * i * i * p4.x;
          float y = j * j * j * p1.y + 3 * j * j * i * p2.y + 3 * j * i * i * p3.y + i * i * i * p4.y;
          drawPoint(x, y, applyColor);
    }
}

public void CGEraser(Vector3 p1,Vector3 p2){
    //To-Do: You need to erase the scene in the area defined by points p1 and p2 in this section.. 
    //   p1  ------
    //      |      |
    //      |      |
    //       ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    
    
    //Utilize the function drawPoint(x, y, color) to apply color to the pixel at coordinates (x, y).
    //For instance: drawPoint(0, 0, color(255, 0, 0)); signifies drawing a red point at (0, 0). 
    //drawPoint(0,0,color(250));
    float w = p2.x - p1.x;
    float h = p2.y - p1.y;
    for (float i = 0; i < h; i+=0.5) {
      for (float j = 0; j < w; j+=0.5) {
          drawPoint(p1.x + j, p1.y + i, color(250));
      }
    }
}

public void drawPoint(float x,float y,color c){
    stroke(c);
    point(x,y);
}

public float distance(Vector3 a,Vector3 b){
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c,c));
}

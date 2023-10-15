public void CGLine(float x1,float y1,float x2,float y2){
    //To-Do: You need to implement the "line algorithm" in this section. 
    //You can use the function line(x1, y1, x2, y2); to verify the correct answer. 
    //However, remember to comment out the function before you submit your homework. 
    //Otherwise, you will receive a score of 0 for this part.
       
    //Utilize the function drawPoint(x, y, color) to apply color to the pixel at coordinates (x, y).
    //For instance: drawPoint(0, 0, color(255, 0, 0)); signifies drawing a red point at (0, 0).   
       
    
   //stroke(0);
   // noFill();
   //line(x1,y1,x2,y2);
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
      
      
}


public void CGCircle(float x,float y,float r){
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
    for(float i = -r; i<= r ;){
       float j =(float) Math.sqrt(r * r - i * i);
       drawPoint(x + i, y + j, color(255, 0, 0));
       drawPoint(x + i, y - j, color(255, 0, 0));
       i = i + 0.05;
    }
}

public void CGEllipse(float x,float y,float r1,float r2){
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
            drawPoint(x + x_b, y + y_b, color(255, 0, 0));
        }
}

public void CGCurve(Vector3 p1,Vector3 p2,Vector3 p3,Vector3 p4){
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
    for (float t = 0; t <= 1; t += 0.001) {
          float u = 1 - t;
          float x = u * u * u * p1.x + 3 * u * u * t * p2.x + 3 * u * t * t * p3.x + t * t * t * p4.x;
          float y = u * u * u * p1.y + 3 * u * u * t * p2.y + 3 * u * t * t * p3.y + t * t * t * p4.y;
          drawPoint(x, y, color(255, 0, 0));
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
    

}

public void drawPoint(float x,float y,color c){
    stroke(c);
    point(x,y);
}

public float distance(Vector3 a,Vector3 b){
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c,c));
}

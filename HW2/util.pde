public void CGLine(float x1,float y1,float x2,float y2){
    //To-Do: Please paste your code from HW1 CGLine.
    float dx = abs(x2-x1);
    float dy = abs(y2-y1);
    float s1,s2;
    if (x2-x1 > 0)  s1 = -1;
    else  s1 = 1;
    if (y2-y1 > 0)  s2 = -1;
    else  s2 = 1;
    float x = x2;
    float y = y2;
    boolean change;
    
    if(dy>dx)
    {
      float temp = dx;
      dx = dy;
      dy = temp;
      change = true;
    }
    else  change = false;
    
    float p = 2*dy-dx;
    for(float i=0;i<=dx;i++)
    {
      drawPoint(x, y, color(0,0,0));
      if(p >= 0)
      {
        if(change)  x = x + s1;
        else  y = y + s2;
        p = p - 2 * dx;
      }
      if(change)  y = y + s2;
      else  x = x + s1;
      p = p + 2 * dy;
    }
}
public boolean outOfBoundary(float x,float y){
    if(x < 0 || x >= width || y < 0 || y >= height) return true;
    return false;
}

public void drawPoint(float x,float y,color c){
    int index = (int)y * width + (int)x;
    if(outOfBoundary(x,y)) return;
    pixels[index] = c;
}

public float distance(Vector3 a,Vector3 b){
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c,c));
}



boolean pnpoly(float x, float y, Vector3[] vertexes) {
  // To-Do : You need to check the coordinate p(x,v) if inside the vertexes. If yes return true.
    
 boolean c = false;
  for (int i = 0, j = vertexes.length - 1; i < vertexes.length; j = i++) {
    // check vertival line and 
      if (((vertexes[i].y > y) != (vertexes[j].y > y)) && 
          (x < (vertexes[j].x - vertexes[i].x) * (y - vertexes[i].y) / (vertexes[j].y - vertexes[i].y) + vertexes[i].x)) {
          c = !c;
      }
  }
  return c;
}

public Vector3[] findBoundBox(Vector3[] v) {
    Vector3 recordminV=new Vector3(1.0/0.0);
    Vector3 recordmaxV=new Vector3(-1.0/0.0);
    // To-Do : You need to find the bounding box of the vertexes v.
    
   //     r1 -------
   //       |   /\  |
   //       |  /  \ |
   //       | /____\|
   //        ------- r2
    for (Vector3 vertex : v) {
        // 更新最小頂點座標
        if (vertex.x < recordminV.x) recordminV.x = vertex.x;
        if (vertex.y < recordminV.y) recordminV.y = vertex.y;
        if (vertex.z < recordminV.z) recordminV.z = vertex.z;

        // 更新最大頂點座標
        if (vertex.x > recordmaxV.x) recordmaxV.x = vertex.x;
        if (vertex.y > recordmaxV.y) recordmaxV.y = vertex.y;
        if (vertex.z > recordmaxV.z) recordmaxV.z = vertex.z;
    }

    Vector3[] result={recordminV, recordmaxV};
    return result;
    

}


public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points,Vector3[] boundary){
    ArrayList<Vector3> input=new ArrayList<Vector3>();
    ArrayList<Vector3> output=new ArrayList<Vector3>();
    for (int i=0; i<points.length; i+=1) {
        input.add(points[i]);
    }
    
    // To-Do
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertexes of the "boundary".
    // The output is the vertexes of the polygon.
    
    for(int i = 0; i < boundary.length; i++){
      Vector3 boundaryEdgeStart = boundary[i];
      Vector3 boundaryEdgeEnd = boundary[(i + 1) % (boundary.length)];
    
      //System.out.print(boundaryEdgeStart);
      //System.out.print('\n');
      //System.out.print(boundaryEdgeEnd);
      //System.out.print('\n');
      
      output.clear();
      Vector3 previousShapePoint = input.get(input.size() - 1);
      //System.out.print(previousShapePoint);
      Vector3 currentShapePoint = input.get(0);
      for(int j = 0; j < input.size(); j++){
        currentShapePoint = input.get(j);
        
        if(isInside(boundaryEdgeStart, boundaryEdgeEnd, currentShapePoint)){
          if(!isInside(boundaryEdgeStart, boundaryEdgeEnd, previousShapePoint)){
            Vector3 intersection = computeIntersection(boundaryEdgeStart, boundaryEdgeEnd, previousShapePoint, currentShapePoint);
            output.add(intersection);
          }
          else{
            output.add(currentShapePoint);
          }
        }else if(isInside(boundaryEdgeStart, boundaryEdgeEnd, previousShapePoint)){
          Vector3 intersection = computeIntersection(boundaryEdgeStart, boundaryEdgeEnd, previousShapePoint, currentShapePoint);
          output.add(intersection);
        }
        previousShapePoint = currentShapePoint;
      }
     
      if(output.isEmpty()){
        output.addAll(input);
      }
      
     input.clear();
     input.addAll(output);
    
    }
    
    
    
    Vector3[] result=new Vector3[output.size()];
    for (int i=0; i<result.length; i+=1) {
        result[i]=output.get(i);
    }
    return result;
}

private static boolean isInside(Vector3 edgeStart, Vector3 edgeEnd, Vector3 point) {
        return ((edgeEnd.x - edgeStart.x) * (point.y - edgeStart.y) -
                (edgeEnd.y - edgeStart.y) * (point.x - edgeStart.x)) >= 0;
    }

private static Vector3 computeIntersection(Vector3 edgeStart, Vector3 edgeEnd, Vector3 insidePoint, Vector3 outsidePoint) {
    float t = ((edgeEnd.x - edgeStart.x) * (insidePoint.y - edgeStart.y) -
               (edgeEnd.y - edgeStart.y) * (insidePoint.x - edgeStart.x)) /
              ((edgeEnd.x - edgeStart.x) * (outsidePoint.y - insidePoint.y) -
               (edgeEnd.y - edgeStart.y) * (outsidePoint.x - insidePoint.x));

    float intersectionX = insidePoint.x + t * (outsidePoint.x - insidePoint.x);
    float intersectionY = insidePoint.y + t * (outsidePoint.y - insidePoint.y);

    return new Vector3(intersectionX, intersectionY, 0);
}

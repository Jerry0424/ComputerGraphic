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
    
  boolean c=false;
int n = vertexes.length;
    for (int i = 0, j = n - 1; i < n; j = i++) {
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
    
    
     output = input;
    
    
    
    Vector3[] result=new Vector3[output.size()];
    for (int i=0; i<result.length; i+=1) {
        result[i]=output.get(i);
    }
    return result;
}

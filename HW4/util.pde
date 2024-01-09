public void CGLine(float x1, float y1, float x2, float y2) {
    stroke(0);
    line(x1, y1, x2, y2);
}
public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height) return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int)y * width + (int)x;
    if (outOfBoundary(x, y)) return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}



boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // HW2
    // To-Do : You need to check the coordinate p(x,v) if inside the vertexes. If yes return true.
    boolean flag = false;
    for (int i = 0, j = vertexes.length - 1; i < vertexes.length; j = i++) {
        if (((vertexes[i].y > y) != (vertexes[j].y > y)) && (x < (vertexes[j].x - vertexes[i].x) * (y - vertexes[i].y) / (vertexes[j].y - vertexes[i].y) + vertexes[i].x)) {
            flag = !flag;
        }
    }
    return flag;
}

public Vector3[] findBoundBox(Vector3[] v) {
    Vector3 recordminV=new Vector3(1.0/0.0);
    Vector3 recordmaxV=new Vector3(-1.0/0.0);
    // HW2
    // To-Do : You need to find the bounding box of the vertexes v.

    //     r1 -------
    //       |   /\  |
    //       |  /  \ |
    //       | /____\|
    //        ------- r2
    for (Vector3 vertex : v) {
        // find min vertex coordinate
        if (vertex.x < recordminV.x) recordminV.x = vertex.x;
        if (vertex.y < recordminV.y) recordminV.y = vertex.y;
        if (vertex.z < recordminV.z) recordminV.z = vertex.z;

        // find max vertex coordinate
        if (vertex.x > recordmaxV.x) recordmaxV.x = vertex.x;
        if (vertex.y > recordmaxV.y) recordmaxV.y = vertex.y;
        if (vertex.z > recordmaxV.z) recordmaxV.z = vertex.z;
    }

    Vector3[] result={recordminV, recordmaxV};
    return result;
}


public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input=new ArrayList<Vector3>();
    ArrayList<Vector3> output=new ArrayList<Vector3>();
    for (int i=0; i<points.length; i+=1) {
        input.add(points[i]);
    }

    // HW2
    // To-Do
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertexes of the "boundary".
    // The output is the vertexes of the polygon.
    for(int i = 0; i < boundary.length; i++){
      Vector3 boundaryEdgeStart = boundary[i];
      Vector3 boundaryEdgeEnd = boundary[(i + 1) % (boundary.length)];
      
      output.clear();
      
      Vector3 currentShapePoint;
      Vector3 nextShapePoint;
      
      for(int j = 0; j < input.size(); j++){
        currentShapePoint = input.get(j);
        nextShapePoint = input.get((j + 1) % (input.size()));
        
        if(isInside(boundaryEdgeStart, boundaryEdgeEnd, nextShapePoint)){
         if(!isInside(boundaryEdgeStart, boundaryEdgeEnd, currentShapePoint)){
           output.add(boundaryIntersection(boundaryEdgeStart, boundaryEdgeEnd, nextShapePoint, currentShapePoint));
         }
         output.add(nextShapePoint);
        }
        else if (isInside(boundaryEdgeStart, boundaryEdgeEnd, currentShapePoint)){
          output.add(boundaryIntersection(boundaryEdgeStart, boundaryEdgeEnd, currentShapePoint, nextShapePoint));
        }
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


private static boolean isInside(Vector3 boundaryEdgeStart, Vector3 boundaryEdgeEnd, Vector3 checkPoint) {
  // Vector Product to check point position     (a.x *b.y) - (b.x - a.y)  ==>  <  0(left),  > 0 (right)
  // box   
  //        ------>
  //       ^       |
  //       |       |
  //       |       |
  //       |       V 
  //       <-------
  
  float boundaryX =  boundaryEdgeEnd.x - boundaryEdgeStart.x;   // a.x
  float boundaryY =  boundaryEdgeEnd.y - boundaryEdgeStart.y;   // a.y
  float pointX =  checkPoint.x - boundaryEdgeStart.x;           // b.x
  float pointY =  checkPoint.y - boundaryEdgeStart.y;           // b.y
  
  return ((boundaryX * pointY) - (boundaryY * pointX) <= 0);    // <= 0 indicate the point is inside the box
}

private static Vector3 boundaryIntersection(Vector3 boundaryEdgeStart, Vector3 boundaryEdgeEnd, Vector3 inside, Vector3 outside) {
  // compute the  boundary intersection point of boundary edges and edge consist of inside and outside point
  
    float x1 = boundaryEdgeStart.x, y1 = boundaryEdgeStart.y;
    float x2 = boundaryEdgeEnd.x, y2 = boundaryEdgeEnd.y;
    float x3 = inside.x, y3 = inside.y;
    float x4 = outside.x, y4 = outside.y;
    
    float product = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / product;
    
    return new Vector3((x1 + t * (x2 - x1)), (y1 + t * (y2 - y1)), 0);
}

public float getDepth(float x, float y, Vector3[] vertex ) {
    // To - Do (HW3)
    // You need to calculate the depth (z) in the triangle (vertex) based on the positions x and y. and return the z value;
     Vector3 v0 = vertex[1].sub(vertex[0]);
    Vector3 v1 = vertex[2].sub(vertex[0]);
    Vector3 v2 = new Vector3((x - vertex[0].x), (y - vertex[0].y), 0);

    float d00 = Vector3.dot(v0, v0);
    float d01 = Vector3.dot(v0, v1);
    float d11 = Vector3.dot(v1, v1);
    float d20 = Vector3.dot(v2, v0);
    float d21 = Vector3.dot(v2, v1);

    //compute the Barycentric Coordinates (a, b, c)
    float d = d00 * d11 - d01 * d01;
    float b = (d11 * d20 - d01 * d21) / d;
    float c = (d00 * d21 - d01 * d20) / d;
    float a = 1.0f - b - c;

    return a * vertex[0].z + b * vertex[1].z + c * vertex[2].z;
    
}

float[] barycentric(Vector3 P, Vector4[] verts) {

    Vector3 A=verts[0].homogenized();
    Vector3 B=verts[1].homogenized();
    Vector3 C=verts[2].homogenized();

    Vector4 AW = verts[0];
    Vector4 BW = verts[1];
    Vector4 CW = verts[2];

   
    // To - Do (HW4)
    // Calculate the barycentric coordinates of point P in the triangle verts using the barycentric coordinate system.
    // Please notice that you should use Perspective-Correct Interpolation otherwise you will get wrong answer.
    
    // compute the barycentric coordinates 
    
    // A.x * a + B.x * b + C.x * c =  P.x
    // A.y * a + B.y * b + C.y * c =  P.y
    // c = 1 - a - b
    // (A.x - C.x) * a + (B.x - C.x) * b = P.x - C.x
    // (A.y - C.y) * a + (B.y - C.y) * b = P.y - C.y
    
    float a1 = A.x - C.x;
    float b1 = B.x - C.x; 
    float c1 = P.x - C.x;
    float a2 = A.y - C.y;
    float b2 = B.y - C.y; 
    float c2 = P.y - C.y;
    
    float det = a1 * b2 -  a2 * b1;
    
    float alpha = (c1 * b2 - b1 * c2) / det;
    float beta = (a1 * c2 - c1* a2) / det;
    float gamma =  1 - alpha - beta;
    
    //// do the Perspective-Correct
    //alpha = (alpha / AW.w) * A.x + (beta / BW.w) * B.x + (gamma / CW.w) * C.x;
    //beta = (alpha / AW.w) * A.y + (beta / BW.w) * B.y + (gamma / CW.w) * C.y;
    //gamma = (alpha / AW.w) * A.z + (beta / BW.w) * B.z + (gamma / CW.w) * C.z;

    alpha /= (AW.w + alpha * (BW.w - AW.w) + beta * (CW.w - AW.w));
    beta /= (AW.w + alpha * (BW.w - AW.w) + beta * (CW.w - AW.w));
    gamma /= (AW.w + alpha * (BW.w - AW.w) + beta * (CW.w - AW.w));
    
    float[] result={alpha, beta, gamma};
    return result;
}


Vector3 interpolation(float[] abg, Vector3[] v) {
    return v[0].mult(abg[0]).add(v[1].mult(abg[1])).add(v[2].mult(abg[2]));
}

Vector4 interpolation(float[] abg, Vector4[] v) {
    return v[0].mult(abg[0]).add(v[1].mult(abg[1])).add(v[2].mult(abg[2]));
}

float interpolation(float[] abg, float[] v) {
    return v[0]*abg[0] + v[1]*abg[1] + v[2]*abg[2];
}

public class PhongVertexShader extends VertexShader{
    Vector4[][] main(Object[] attribute,Object[] uniform){
        Vector3[] aVertexPosition = (Vector3[])attribute[0];
        Vector3[] aVertexNormal = (Vector3[])attribute[1];
        Matrix4 MVP = (Matrix4)uniform[0];
        Matrix4 M = (Matrix4)uniform[1];
        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];
        
        for(int i=0;i<gl_Position.length;i++){
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(aVertexNormal[i].getVector4(0.0));
        }
        
        Vector4[][] result = {gl_Position,w_position,w_normal};
        
        return result;
    }
}

public class PhongFragmentShader extends FragmentShader{
    Vector4 main(Object[] varying){
        Vector3 position = (Vector3)varying[0];
        Vector3 w_position = (Vector3)varying[1];
        Vector3 w_normal = (Vector3)varying[2];
        Vector3 albedo = (Vector3) varying[3];
        Vector3 kdksm = (Vector3) varying[4];
        Light light = basic_light;
        Camera cam = main_camera;
        
        
        // To - Do (HW4)
        // In this section, we have passed in all the variables you need. 
        // Please use these variables to calculate the result of Phong shading 
        // for that point and return it to GameObject for rendering
        
        // compute the lighting
        Vector3 lightDirection = (light.transform.position.sub(w_position)).unit_vector();
        Vector3 viewDirection = (cam.transform.position.sub(w_position)).unit_vector();
        Vector3 normal = w_normal.unit_vector();
        
        // compute ambient
        Vector3 ambient = light.light_color.product(AMBIENT_LIGHT);

        // compute diffuse 
        Vector3 diffuse = light.light_color.mult(Vector3.dot(normal, lightDirection)).mult(kdksm.x);
        
        // compute reflection vector: 2N* dot(N, L) - L
        Vector3 reflectDirection = normal.mult(2).mult(Vector3.dot(normal, lightDirection)).sub(lightDirection);
        
        //compute specualr
        Vector3 specular = light.light_color.mult(kdksm.y).mult((float)Math.pow(Vector3.dot(reflectDirection, viewDirection),kdksm.z));
        
        // compute the object color  
        Vector3 result = (ambient.add(diffuse).add(specular)).product(albedo);

        return new Vector4(result.x, result.y, result.z, 1.0);
    }
}



public class FlatVertexShader extends VertexShader{
   Vector4[][] main(Object[] attribute,Object[] uniform){
        Vector3[] aVertexPosition = (Vector3[])attribute[0];
        Matrix4 MVP = (Matrix4)uniform[0];
        Matrix4 M = (Matrix4)uniform[1];
        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];
        
        
        Vector3 P = aVertexPosition[1].sub(aVertexPosition[0]);
        Vector3 Q = aVertexPosition[2].sub(aVertexPosition[0]);
        Vector3 normal = Vector3.cross(P, Q);
        
        for(int i=0;i<gl_Position.length;i++){
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(normal.getVector4(0.0));
        }
        
        Vector4[][] result = {gl_Position,w_position,w_normal};
        
        return result;
    }
}

public class FlatFragmentShader extends FragmentShader{
    Vector4 main(Object[] varying){
        Vector3 position = (Vector3)varying[0];
        Vector3 w_position = (Vector3)varying[1];
        Vector3 w_normal = (Vector3)varying[2];
        Vector3 albedo = (Vector3) varying[3];
        Vector3 kdksm = (Vector3) varying[4];
        Light light = basic_light;
        Camera cam = main_camera;
        // To - Do (HW4)
        // Here you must complete Flat shading. 
        // We have instantiated the relevant Material, and you may be missing some variables. 
        // Please refer to the templates of Phong Material and Phong Shader to complete this part.
        
        // Note : In the fragment shader, the first 'varying' variable must be its screen position. 
        // Subsequent variables will be received in order from the vertex shader. 
        // Additional variables needed will be passed by the material later.
        
        Vector3 lightDirection = (light.transform.position.sub(w_position)).unit_vector();
        Vector3 viewDirection = (cam.transform.position.sub(w_position)).unit_vector();
        Vector3 normal = w_normal.unit_vector();
        
        // compute ambient
        Vector3 ambient = light.light_color.product(AMBIENT_LIGHT);

        // compute diffuse 
        Vector3 diffuse = light.light_color.mult(Vector3.dot(normal, lightDirection)).mult(kdksm.x);
        
        // compute reflection vector: 2N* dot(N, L) - L
        Vector3 reflectDirection = normal.mult(2).mult(Vector3.dot(normal, lightDirection)).sub(lightDirection);
        
        //compute specualr
        Vector3 specular = light.light_color.mult(kdksm.y).mult((float)Math.pow(Vector3.dot(reflectDirection, viewDirection),kdksm.z));
        
        // compute the object color  

        Vector3 result = (ambient.add(diffuse).add(specular)).product(albedo);
        
        return new Vector4(result.x, result.y, result.z, 1.0);
    }
}



public class GroundVertexShader extends VertexShader{
    Vector4[][] main(Object[] attribute,Object[] uniform){
        Vector3[] aVertexPosition = (Vector3[])attribute[0];
        Vector3[] aVertexNormal = (Vector3[])attribute[1];
        Vector3 albedo = (Vector3)attribute[2];
        Vector3 kdksm = (Vector3)attribute[3];
       
        Matrix4 MVP = (Matrix4)uniform[0];
        Matrix4 M = (Matrix4)uniform[1];
        
        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];
        Vector4[] resultColor = new Vector4[3];
        
        Light light = basic_light;
        Camera cam = main_camera;
        
        // To - Do(HW4)
        // Here you must complete Ground shading. 
        // We have instantiated the relevant Material, and you may be missing some variables. 
        // Please refer to the templates of Phong Material and Phong Shader to complete this part.
        
        // Note: Here the first variable must return the position of the vertex. 
        // Subsequent variables will be interpolated and passed to the fragment shader. The return value must be a Vector4.
        for(int i=0;i<gl_Position.length;i++){
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(aVertexNormal[i].getVector4(0.0));
        }
        
        for(int i=0;i<gl_Position.length;i++){
            Vector3 lightDirection = (light.transform.position.sub(w_position[i].xyz())).unit_vector();
            Vector3 viewDirection = (cam.transform.position.sub(w_position[i].xyz())).unit_vector();
            Vector3 normal = w_normal[i].xyz().unit_vector();
        
            // compute ambient
            Vector3 ambient = light.light_color.product(AMBIENT_LIGHT);
      
            // compute diffuse 
            Vector3 diffuse = light.light_color.mult(Vector3.dot(normal, lightDirection)).mult(kdksm.x);
            
            // compute reflection vector: 2N* dot(N, L) - L
            Vector3 reflectDirection = normal.mult(2).mult(Vector3.dot(normal, lightDirection)).sub(lightDirection);
            
            //compute specualr
            Vector3 specular = light.light_color.mult(kdksm.y).mult((float)Math.pow(Vector3.dot(reflectDirection, viewDirection),kdksm.z));
            
            // compute the object color  
      
            Vector3 Color = (ambient.add(diffuse).add(specular)).product(albedo);
        
            resultColor[i] = Color.getVector4(1.0);
            
        }
        
        Vector4[][] result = {gl_Position, resultColor};
        
        return result;
    }
    
    // test
    //Vector4[][] main(Object[] attribute,Object[] uniform){
    //    Vector3[] aVertexPosition = (Vector3[])attribute[0];
    //    Matrix4 MVP = (Matrix4)uniform[0];
    //    Vector4[] gl_Position = new Vector4[3];   
        
    //    // To - Do
        
        
    //    for(int i=0;i<gl_Position.length;i++){
    //        gl_Position[i] = aVertexPosition[i].getVector4(1.0);
    //    }
        
    //    Vector4[][] result = {gl_Position,new Vector4[]{new Vector4(1,0,0,0),new Vector4(0,1,0,0),new Vector4(0,0,1,0)}};
        
    //    return result;
    //}
}

public class GroundFragmentShader extends FragmentShader{
    Vector4 main(Object[] varying){
        Vector3 position = (Vector3)varying[0];
        Vector4 resultColor = (Vector4)varying[1];
        
        // To - Do (HW4)
        // Here you must complete Ground shading. 
        // We have instantiated the relevant Material, and you may be missing some variables. 
        // Please refer to the templates of Phong Material and Phong Shader to complete this part.
        
        // Note : In the fragment shader, the first 'varying' variable must be its screen position. 
        // Subsequent variables will be received in order from the vertex shader. 
        // Additional variables needed will be passed by the material later.
        
        return resultColor.mult(-75);
    }
    
    // test
  //Vector4 main(Object[] varying){
  //      Vector3 position = (Vector3)varying[0];
  //      Vector3 col = (Vector3)varying[1];
  //      // To - Do

        
  //      return new Vector4(col.x,col.y,col.z,1.0);
  //  }
}

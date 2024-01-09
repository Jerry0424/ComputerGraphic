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
        float diff = Math.max(0.0, Vector3.dot(normal, lightDirection));
        Vector3 diffuse = light.light_color.mult(diff).mult(kdksm.x);
        
        // compute reflection vector
        Vector3 reflectDirection = normal.mult(Vector3.dot(normal, lightDirection)).mult(2).sub(lightDirection);
        
        //compute specualr
        Vector3 specular = light.light_color.mult(kdksm.y).mult((float)Math.pow(Vector3.dot(reflectDirection, viewDirection),kdksm.z));
        
        Vector3 result = new Vector3(
            ambient.x * albedo.x + diffuse.x * albedo.x + specular.x * albedo.x,
            ambient.y * albedo.y + diffuse.y * albedo.y + specular.y * albedo.y,
            ambient.z * albedo.z + diffuse.z * albedo.z + specular.z * albedo.z
        );

        
        result.x = Math.max(0.0, Math.min(1.0, result.x));
        result.y = Math.max(0.0, Math.min(1.0, result.y));
        result.z = Math.max(0.0, Math.min(1.0, result.z));

        return new Vector4(result.x, result.y, result.z, 1.0);
        
    }
}



public class FlatVertexShader extends VertexShader{
    Vector4[][] main(Object[] attribute,Object[] uniform){
        Vector3[] aVertexPosition = (Vector3[])attribute[0];
        Matrix4 MVP = (Matrix4)uniform[0];
        Vector4[] gl_Position = new Vector4[3];   
        
        // To - Do (HW4)
        // Here you must complete Flat shading. 
        // We have instantiated the relevant Material, and you may be missing some variables. 
        // Please refer to the templates of Phong Material and Phong Shader to complete this part.
        
        
        // Note: Here the first variable must return the position of the vertex. 
        // Subsequent variables will be interpolated and passed to the fragment shader. The return value must be a Vector4.
        
        for(int i=0;i<gl_Position.length;i++){
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
        }
        
        Vector4[][] result = {gl_Position};
        
        return result;
    }
}

public class FlatFragmentShader extends FragmentShader{
    Vector4 main(Object[] varying){
        Vector3 position = (Vector3)varying[0];
        // To - Do (HW4)
        // Here you must complete Flat shading. 
        // We have instantiated the relevant Material, and you may be missing some variables. 
        // Please refer to the templates of Phong Material and Phong Shader to complete this part.
        
        // Note : In the fragment shader, the first 'varying' variable must be its screen position. 
        // Subsequent variables will be received in order from the vertex shader. 
        // Additional variables needed will be passed by the material later.
        
        return new Vector4(0.0,0.0,0.0,1.0);
    }
}



public class GroundVertexShader extends VertexShader{
    Vector4[][] main(Object[] attribute,Object[] uniform){
        Vector3[] aVertexPosition = (Vector3[])attribute[0];
        Matrix4 MVP = (Matrix4)uniform[0];
        
        Vector4[] gl_Position = new Vector4[3];   
        
        // To - Do(HW4)
        // Here you must complete Ground shading. 
        // We have instantiated the relevant Material, and you may be missing some variables. 
        // Please refer to the templates of Phong Material and Phong Shader to complete this part.
        
        // Note: Here the first variable must return the position of the vertex. 
        // Subsequent variables will be interpolated and passed to the fragment shader. The return value must be a Vector4.
        
        for(int i=0;i<gl_Position.length;i++){
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            
        }
        
        Vector4[][] result = {gl_Position};
        
        return result;
    }
}

public class GroundFragmentShader extends FragmentShader{
    Vector4 main(Object[] varying){
        Vector3 position = (Vector3)varying[0];
                
        // To - Do (HW4)
        // Here you must complete Ground shading. 
        // We have instantiated the relevant Material, and you may be missing some variables. 
        // Please refer to the templates of Phong Material and Phong Shader to complete this part.
        
        // Note : In the fragment shader, the first 'varying' variable must be its screen position. 
        // Subsequent variables will be received in order from the vertex shader. 
        // Additional variables needed will be passed by the material later.
        
        
        return new Vector4(0.0,0.0,0.0,1.0);
    }
}

public class Camera {
    Matrix4 projection=new Matrix4();
    Matrix4 worldView=new Matrix4();
    int wid;
    int hei;
    float near;
    float far;
    Transform transform;
    Camera() {
        wid=256;
        hei=256;
        worldView.makeIdentity();
        projection.makeIdentity();
        transform = new Transform();
    }

    Matrix4 inverseProjection() {
        Matrix4 invProjection = Matrix4.Zero();
        float a = projection.m[0];
        float b = projection.m[5];
        float c = projection.m[10];
        float d = projection.m[11];
        float e = projection.m[14];
        invProjection.m[0] = 1.0f / a;
        invProjection.m[5] = 1.0f / b;
        invProjection.m[11] = 1.0f / e;
        invProjection.m[14] = 1.0f / d;
        invProjection.m[15] = -c / (d * e);
        return invProjection;
    }

    Matrix4 Matrix() {
        return projection.mult(worldView);
    }


    void setSize(int w, int h, float n, float f) {
        wid = w;
        hei = h;
        near = n;
        far = f;
        // To - Do
        // This function takes four parameters, which are the width of the screen, the height of the screen
        // the near plane and the far plane of the camera.
        // Where GH_FOV has been declared as a global variable.
        // Finally, pass the result into projection matrix.
        projection = Matrix4.Identity();
        
        float aspectRatio = (float) wid / hei;
        float fovRadians = (float) Math.toRadians(GH_FOV);
        float tanScale = (float) Math.tan(fovRadians / 2.0f) * near;
        float right = aspectRatio * tanScale;
        float top = tanScale;

        projection.m[0] = (float) near / right;
        projection.m[5] = (float) near / top ;
        projection.m[10] = (float) (-1 * (far + near)) / (far - near);
        projection.m[11] = (float) (- 2 * (far * near)) / (far - near);
        projection.m[14] = -1.0f;
        projection.m[15] = 0;
    }
    void setPositionOrientation(Vector3 pos, float rotX, float rotY) {
    }

    void setPositionOrientation(Vector3 pos, Vector3 lookat) {
        // To - Do
        // This function takes two parameters, which are the position of the camera and the point the camera is looking at.
        // We uses topVector = (0,1,0) to calculate the eye matrix.
        // Finally, pass the result into worldView matrix.

        // world space to eye space
        // X : right direction
        // Y : top direction
        // Z : view direction
        worldView = Matrix4.Identity();
        // set the default top vector
        Vector3 top = new Vector3(0, 1, 0); 
        // set the camera look direction  by lookat(view point) minus pos(camera position)
        Vector3 Z = Vector3.sub(lookat, pos).unit_vector(); 
        // set the right as X by cross of top and Z 
        Vector3 X = Vector3.cross(top, Z).unit_vector(); 
        // set the true top as Y by cross of X and Z
        Vector3 Y = Vector3.cross(Z, X).unit_vector();
        
        // set the rotation for camera to look at point lookat 
        worldView.m[0] = X.x();
        worldView.m[1] = X.y();
        worldView.m[2] = X.z();
        
        worldView.m[4] = Y.x();
        worldView.m[5] = Y.y();
        worldView.m[6] = Y.z();
        
        worldView.m[8] = -Z.x();
        worldView.m[9] = -Z.y();
        worldView.m[10] = -Z.z();
        
        // Compute the translation in x, y, z coordinate
        worldView.m[3] = -Vector3.dot(X, pos);
        worldView.m[7] = -Vector3.dot(Y, pos);
        worldView.m[11] = Vector3.dot(Z, pos); 
    }
}

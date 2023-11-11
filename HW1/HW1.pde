ShapeButton lineButton;
ShapeButton circleButton;
ShapeButton polygonButton;
ShapeButton ellipseButton;
ShapeButton curveButton;
ShapeButton pencilButton;
ShapeButton eraserButton;
ShapeButton mizuColor;
ShapeButton kohakuColor;
ShapeButton kihadaColor;
ShapeButton karachaColor;
ShapeButton redColor;
ShapeButton blueColor;
ShapeButton greenColor;
ShapeButton blackColor;

color setColor;

Button clearButton;

ShapeRenderer shapeRenderer;
ArrayList<ShapeButton> shapeButton;
float eraserSize = 20;

public void setup(){
    size(1000,800);
    background(255);
    shapeRenderer = new ShapeRenderer();
    initButton();
    
}

public void draw(){

    background(255);
    for(ShapeButton sb:shapeButton){
        sb.run( () -> {
            sb.beSelect();
            shapeRenderer.setRenderer(sb.getRendererType());
        });
    }  
    
    clearButton.run(()->{shapeRenderer.clear();});
    shapeRenderer.box.show();

    shapeRenderer.run();
   
    
}

void resetButton(){
  for(ShapeButton sb:shapeButton){
    sb.setSelected(false);
  }
}

public void initButton(){
  shapeButton = new ArrayList<ShapeButton>();
  lineButton = new ShapeButton(10,10,30,30){
      @Override
      public void show(){
          super.show();
          stroke(0);
          line(pos.x+2,pos.y+2,pos.x+size.x-2,pos.y+size.y-2);
      }      
      @Override
      public Renderer getRendererType(){
          return new LineRenderer(setColor);
      }
  };
  
  lineButton.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(lineButton);
  
  circleButton = new ShapeButton(45,10,30,30){
      @Override
      public void show(){
          super.show();
          stroke(0);
          circle(pos.x+size.x/2,pos.y+size.y/2,size.x-2);
      }
      @Override
      public Renderer getRendererType(){
          return new CircleRenderer(setColor);
      }
  };
  circleButton.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(circleButton);
  
  polygonButton = new ShapeButton(80,10,30,30){
      @Override
      public void show(){
          super.show();
          stroke(0);
          line(pos.x+2,pos.y+2,pos.x+size.x-2,pos.y+2);
          line(pos.x+2,pos.y+size.y-2,pos.x+size.x-2,pos.y+size.y-2);
          line(pos.x+size.x-2,pos.y+2,pos.x+size.x-2,pos.y+size.y-2);
          line(pos.x+2 ,pos.y+2,pos.x + 2,pos.y+size.y-2);          
      }
      @Override
      public Renderer getRendererType(){
          return new PolygonRenderer(setColor);
      }
      
  };
  
  polygonButton.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(polygonButton);
  
  
  ellipseButton = new ShapeButton(115,10,30,30){
      @Override
      public void show(){
          super.show();
          stroke(0);
          ellipse(pos.x+size.x/2,pos.y+size.y/2,size.x-2,size.y*2/3);      
      }
      @Override
      public Renderer getRendererType(){
          return new EllipseRenderer(setColor);
      }
      
  };
  
  ellipseButton.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(ellipseButton);
  
  curveButton = new ShapeButton(150,10,30,30){
      @Override
      public void show(){
          super.show();
          stroke(0);
          bezier(pos.x,pos.y,pos.x,pos.y+size.y,pos.x+size.x,pos.y,pos.x+size.x,pos.y+size.y);      
      }
      @Override
      public Renderer getRendererType(){
          return new CurveRenderer(setColor);
      }
      
  };
  
  curveButton.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(curveButton);
  
  clearButton = new Button(width-50,10,30,30);
  clearButton.setBoxAndClickColor(color(250),color(150));
  clearButton.setImage(loadImage("clear.png"));
  
  pencilButton = new ShapeButton(185,10,30,30){
      @Override
      public Renderer getRendererType(){
          return new PencilRenderer(setColor);
      }    
  };
  pencilButton.setImage(loadImage("pencil.png"));
  
  pencilButton.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(pencilButton);
  
  eraserButton = new ShapeButton(220,10,30,30){
      @Override
      public Renderer getRendererType(){
          return new EraserRenderer();
      }    
  };
  eraserButton.setImage(loadImage("eraser.png"));
  
  eraserButton.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(eraserButton);
  
  
  mizuColor = new ShapeButton(260,10,20,20){
      @Override
      public Renderer getRendererType(){
          setColor = color(129, 199, 212);
          return new colorRenderer();
      }
  };
  mizuColor.setImage(loadImage("mizu.png"));
  
  mizuColor.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(mizuColor);
  
  kohakuColor = new ShapeButton(290,10,20,20){
      @Override
      public Renderer getRendererType(){
          setColor = color(202, 122, 44);
          return new colorRenderer();
      }
  };
  kohakuColor.setImage(loadImage("kohaku.png"));
  
  kohakuColor.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(kohakuColor);
  
  
  kihadaColor = new ShapeButton(320,10,20,20){
    @Override
    public Renderer getRendererType(){
        setColor = color(251, 226, 81);
        return new colorRenderer();
    }
  };
  kihadaColor.setImage(loadImage("kihada.png"));
  
  kihadaColor.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(kihadaColor);
  
  karachaColor = new ShapeButton(350,10,20,20){
      @Override
      public Renderer getRendererType(){
          setColor = color(180, 113, 87);
          return new colorRenderer();
      }
  };
  karachaColor.setImage(loadImage("karacha.png"));
  
  karachaColor.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(karachaColor);
  
  
   blueColor = new ShapeButton(380,10,20,20){
      @Override
      public Renderer getRendererType(){
          setColor = color(0, 0, 255);
          return new colorRenderer();
      }
  };
  blueColor.setImage(loadImage("blue.png"));
  
  blueColor.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(blueColor);
  
  greenColor = new ShapeButton(410,10,20,20){
      @Override
      public Renderer getRendererType(){
          setColor = color(0, 255, 0);
          return new colorRenderer();
      }
  };
  greenColor.setImage(loadImage("green.png"));
  
  greenColor.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(greenColor);
  
  
  redColor = new ShapeButton(440,10,20,20){
    @Override
    public Renderer getRendererType(){
        setColor = color(255, 0, 0);
        return new colorRenderer();
    }
  };
  redColor.setImage(loadImage("red.png"));
  
  redColor.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(redColor);
  
  blackColor = new ShapeButton(470,10,20,20){
      @Override
      public Renderer getRendererType(){
          setColor = color(0, 0, 0);
          return new colorRenderer();
      }
  };
  blackColor.setImage(loadImage("black.png"));
  
  blackColor.setBoxAndClickColor(color(250),color(150));
  shapeButton.add(blackColor);
  
}



public void keyPressed(){
    if(key=='z'||key=='Z'){
        shapeRenderer.popShape();
    }

}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e < 0) eraserSize += 1;
  else if(e > 0) eraserSize -= 1;
  eraserSize  = max(min(eraserSize,30),4);
}

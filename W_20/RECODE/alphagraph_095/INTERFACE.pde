/*
 * A very sloppy collection of variables
 * along with all GUI objects & methods.
 *
 */

//////////////////////// INTERFACE VARIABLES
float STROKEW, STROKEC;
float DIA, DIAX, DIAY, LEN;
int THETALINE;
// variable for fine tuning of angles with right & left keys
float THETAFINE;

float THETA_CIRCLES;
float KEN_P_AMM, KEN_P_FACT, KEN_F_AMM, PL_SCALE, PL_AMM;
int HUE, SAT, BRIGHTNESS, HUE2, SAT2, BRIGHTNESS2;

float STEPX, STEPY, XOFF, YOFF, STEPXDOT, STEPYDOT;
boolean SHOWLINES, NOISE_01, NOISE_02, ANIMATE, ANIME_LINES,
  MOUSE_ANIME, NOISE_THETA_LINE, SUPERPERLIN_LINE;
boolean SHOWCIRCLES, SYMMETRIC, isStrokeC, isInvert;
boolean SAVEPRESET, LOADPRESET;
String getFont;

float FONT_SIZE;

Toggle mt1;
Toggle mt2;
Textfield myTextfield;
ScrollableList d1;

//////////////////////////////////////////

void controlInit() {
  PFont p = loadFont("FiraMono-Regular-11.vlw");
  textFont(p, 11);
  INTERFACES  = new ControlP5(this, p);
  //fontIndex = 1;

/*
  // Custom scrollable list
  String[] fontList = PFont.list();
  d1 = INTERFACES.addScrollableList("FontsList")
    .setPosition(800, 5)
    .setWidth(180)
    .setBarHeight(20)
    .setItemHeight(25)
    .open()
    .addItems(fontList);
*/
  //////////////////////////////////// Add GROUP 1
  Group g1  =  INTERFACES.addGroup("g1")
    .setPosition(10, 20)
    .setWidth(180)
    .activateEvent(true)
    .setBackgroundColor(color( 255,33 ))  //#CED2DB, #C9BFBF #E0EAFF
    .setBackgroundHeight(245)
    .setLabel("FORM")
    .setBarHeight(14);

  ///////////////////////////////////////////////////////////////////// GROUP 1 SETTINGS GEOMETRY
  // LINES
  Slider ls1 = INTERFACES.addSlider("LEN").setPosition(10, 20)
    .setRange(0.0, 60.0).setValue(50.0).setHeight(20).setWidth(120)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);


  Numberbox nb1 = INTERFACES.addNumberbox("STROKEW").setPosition(10, 45)
    .setRange(0.0, 60.0).setValue(2.0)
      .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
        .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);
          makeEditable( nb1 );


  Numberbox nb2 = INTERFACES.addNumberbox("THETALINE").setPosition(85, 45)
    .setRange(ceil(0), ceil(360)).setValue(0).setCaptionLabel("ROTATE")
    //.setNumberOfTickMarks(4)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);
  makeEditable( nb2 );


  Toggle lt1 = INTERFACES.addToggle("SHOWLINES").setPosition(10, 90)
    .setSize(15, 15).setValue(true).setCaptionLabel("LINE")
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);


  Toggle lt2 = INTERFACES.addToggle("SHOWCIRCLES").setPosition(60, 90)
    .setSize(15, 15).setValue(true).setCaptionLabel("POINT")
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);


  Toggle lt3 = INTERFACES.addToggle("SYMMETRIC").setPosition(115, 90)
    .setSize(15, 15).setValue(true)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);


  Toggle lt4 = INTERFACES.addToggle("isStrokeC").setPosition(90, 200)
    .setSize(15, 15).setValue(false).setCaptionLabel("stroke")
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);


  Toggle t5 = INTERFACES.addToggle("isInvert").setPosition(135, 200)
    .setSize(15, 15).setValue(false).setCaptionLabel("INVERT")
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);


  // CIRCLES
  Slider ls4 = INTERFACES.addSlider("DIA").setPosition(10, 130)
    .setRange(0.0, 40.0).setValue(5.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);


  Slider ls5 = INTERFACES.addSlider("DIAX").setPosition(10, 145)
    .setRange(0.0, 40.0).setValue(2.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);

  Slider ls6 = INTERFACES.addSlider("DIAY").setPosition(10, 160)
    .setRange(0.0, 40.0).setValue(2.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);

  Slider ls7 = INTERFACES.addSlider("THETA_CIRCLES").setPosition(10, 175)
    .setRange(0.0, TWO_PI).setValue(2.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);
  ls7.setLabel("ROTATE");

  Numberbox nb3 = INTERFACES.addNumberbox("STROKEC").setPosition(10, 200)
    .setRange(0.1, 50.0).setValue(0.5)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g1);
  nb3.setLabel("THICKNESS");
  makeEditable( nb3 );


  ///////////////////////////////////////////////////////////////////// GROUP 2 COLOUR

  Group g2  =  INTERFACES.addGroup("g2")
    .setPosition(400, 20)
    .setWidth(190)
    .activateEvent(true)
    .setBackgroundColor(color( 255,33 ))
    .setBackgroundHeight(180)
    .setLabel("COLOUR")
    .setBarHeight(14);


  //////////////////////////////////// GROUP 2 SETTINGS
  // Circles
  Slider col1 = INTERFACES.addSlider("HUE").setPosition(10, 20)
    .setRange(0, 360).setValue(230)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g2);
  Slider col2 = INTERFACES.addSlider("SAT").setPosition(10, 35)
    .setRange(0, 100).setValue(0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g2);
  Slider col3 = INTERFACES.addSlider("BRIGHTNESS").setPosition(10, 50)
    .setRange(0, 100).setValue(100)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g2);

  // Lines

  Slider col4 = INTERFACES.addSlider("HUE2").setPosition(10, 65)
    .setRange(0, 360).setValue(0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g2);
  Slider col5 = INTERFACES.addSlider("SAT2").setPosition(10, 80)
    .setRange(0, 100).setValue(100)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g2);
  Slider col6 = INTERFACES.addSlider("BRIGHTNESS2").setPosition(10, 95)
    .setRange(0, 100).setValue(100)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g2);


  ///////////////////////////////////////////////////////////////////// GROUP 3 PERLIN NOISE PARAMS
  Group g3  =  INTERFACES.addGroup("g3")
    .setPosition(600, 20)
    .setWidth(190)
    .close()
    .activateEvent(true)
    .setBackgroundColor(color( 255,33 ))
    .setBackgroundHeight(180)
    //.setLabel("MOTION")
    .setBarHeight(14);

  //////////////////////////////////// GROUP 3 SETTINGS
  Slider ms1 = INTERFACES.addSlider("KEN_P_AMM").setPosition(10, 20)
    .setRange(1, 100).setValue(30.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);

  //INTERFACES.getTooltip().setDelay(250);
  //INTERFACES.getTooltip().register("KEN_P_AMM", "Amount of Ken Perlin Noise");

  Slider ms2 = INTERFACES.addSlider("KEN_P_FACT").setPosition(10, 35)
    .setRange(0.1, 1.0).setValue(10)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);

  Slider ms3 = INTERFACES.addSlider("KEN_F_AMM").setPosition(10, 50)
    .setRange(0.0001, 0.10).setValue(0.005)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);
  ms3.setLabel("Noise Refine");

  mt1 = INTERFACES.addToggle("NOISE_01").setPosition(10, 70)
    .setSize(10, 10).setValue(false).setCaptionLabel("Mode1")
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);

  //INTERFACES.getTooltip().setDelay(250);
  //INTERFACES.getTooltip().register("NOISE_01", "2D noise with motion applied to Circles");

  mt2 = INTERFACES.addToggle("ANIMATE").setPosition(150, 70)
    .setSize(10, 10).setValue(false).setCaptionLabel("ANIME")
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);

  //INTERFACES.getTooltip().setDelay(250);
  //INTERFACES.getTooltip().register("ANIMATE", "Animate with mouse position");

  Toggle mt3 = INTERFACES.addToggle("NOISE_02").setPosition(60, 70)
    .setSize(10, 10).setValue(false).setCaptionLabel("Mode2")
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);

  //INTERFACES.getTooltip().setDelay(250);
  //INTERFACES.getTooltip().register("NOISE_02", "2D noise without motion applied to Circles");

  Toggle mt4 = INTERFACES.addToggle("ANIME_LINES").setPosition(45, 105)
    .setSize(10, 10).setValue(false).setCaptionLabel("L_ANIME")
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);

  Toggle mt5 = INTERFACES.addToggle("MOUSE_ANIME").setPosition(110, 70)
    .setSize(10, 10).setValue(false).setCaptionLabel("MOUSE")
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);

  //INTERFACES.getTooltip().setDelay(250);
  //INTERFACES.getTooltip().register("MOUSE_ANIME", "Animate with mouse pressed");

  Toggle mt6 = INTERFACES.addToggle("NOISE_THETA_LINE").setPosition(10, 105)
    .setSize(10, 10).setValue(false).setCaptionLabel("PL")
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);

  //INTERFACES.getTooltip().setDelay(250);
  //INTERFACES.getTooltip().register("NOISE_THETA_LINE", "Perlin Noise applied to lines & line length");

  /*
// NOT YET IMPLEMENTED
   Toggle mt7 = INTERFACES.addToggle("SUPERPERLIN_LINE").setPosition(95, 105)
   .setSize(10, 10).setValue(false).setGroup(g3).setCaptionLabel("PL")
   .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
   .setColorValueLabel(#525252).setColorActive(#F08D0C);
   mt7.setLabel("super perlin");
   */
  Slider ms4 = INTERFACES.addSlider("PL_SCALE").setPosition(10, 140)
    .setRange(0.0001, 0.01).setValue(0.001)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);

  Slider ms5 = INTERFACES.addSlider("PL_AMM").setPosition(10, 155)
    .setRange(0.0, 250.00).setValue(10.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g3);
  ms5.setLabel("PL AMM");

  //////////////////////////////////// Add GROUP 4
  Group g4  =  INTERFACES.addGroup("g4")
    .setPosition(200, 20)
    .setWidth(190)
    .activateEvent(true)
    .setBackgroundColor(color( 255,33 ))
    .setBackgroundHeight(220)
    .setLabel("GRID")
    .setBarHeight(14);



  ///////////////////////////////////////////////////////////////////// GROUP 4 SETTINGS GRID PARAMS
  Numberbox nb5 = INTERFACES.addNumberbox("STEPX").setPosition(10, 20)
    .setRange(1.0, 60.0).setValue(10.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g4);
    makeEditable( nb5 );


    Numberbox nb6 = INTERFACES.addNumberbox("STEPY").setPosition(85, 20)
    .setRange(1.0, 60.0).setValue(10.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g4);
    makeEditable( nb6 );
  //INTERFACES.getTooltip().setDelay(250);
  //INTERFACES.getTooltip().register("GRID_STEPX", "Change grid step X values");

  //INTERFACES.getTooltip().setDelay(250);
  //INTERFACES.getTooltip().register("GRID_STEPY", "Change grid step Y values");

   Numberbox nb7 = INTERFACES.addNumberbox("STEPXDOT").setPosition(10, 60)
    .setRange(1.0, 60.0).setValue(15)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g4);
    nb7.setLabel("STEPX_LINES");
    makeEditable( nb7 );

   Numberbox nb8 = INTERFACES.addNumberbox("STEPYDOT").setPosition(85, 60)
    .setRange(1.0, 60.0).setValue(15)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g4);
    nb8.setLabel("STEPY_LINES");
    makeEditable( nb8 );


  Slider gs3 = INTERFACES.addSlider("XOFF").setPosition(10, 115)
    .setRange(-50.0, 50.0).setValue(0.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g4);
  gs3.setLabel("refine x");

  Slider gs4 = INTERFACES.addSlider("YOFF").setPosition(10, 130)
    .setRange(-50.0, 50.0).setValue(0.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g4);
  gs4.setLabel("refine y");


  Bang gb1 = INTERFACES.addBang("bangSave").setPosition(10, 180)
    .setSize(15, 15).setTriggerEvent(Bang.RELEASE).setCaptionLabel("save")
    .setColorBackground(#0D6FBC).setColorForeground(#0D6FBC).setGroup(g4);
  //gb1.setLabel("save a preset");

  Bang gb2 = INTERFACES.addBang("bangLoad").setPosition(50, 180)
    .setSize(15, 15).setTriggerEvent(Bang.RELEASE).setCaptionLabel("load")
    .setColorBackground(#0D6FBC).setColorForeground(#0D6FBC).setGroup(g4);
  //gb2.setLabel("load a preset");


  Bang gb3 = INTERFACES.addBang("bangExport").setPosition(100, 180)
    .setSize(15, 15).setTriggerEvent(Bang.RELEASE).setCaptionLabel("exportPDF")
    .setColorBackground(#0D6FBC).setColorForeground(#0D6FBC).setGroup(g4);
  //gb3.setLabel("export to PDF");


  Slider gs5 = INTERFACES.addSlider("FONT_SIZE").setPosition(10, 145)
    .setRange(0.5, 900.0).setValue(300.0)
    .setColorBackground(#F5F5F5).setColorForeground(#A09E9F)
    .setColorValueLabel(#525252).setColorActive(#F08D0C).setGroup(g4);
  gs5.setLabel("Font Size");


  ///////////////////////////////////////////////////////////// TEXT
 /* Textarea myTextarea = INTERFACES.addTextarea("txt")
    .setPosition(1020, 5)
    .setSize(240, 140)
    //.setFont(createFont("FiraSans", 12))
    .setFont(loadFont("FiraMono-Regular-12.vlw"))
    .setLineHeight(14)
    .setColor(color(128))
    .setColorBackground(color(255, 100))
    .setColorForeground(color(255, 100));
  ;
  myTextarea.setText("Alphagraph is a parametric tool for exploring letter forms."
    +"\nDeveloped by mark webster"
    +"\n"
    +"\n- Use save & load buttons for presets."
    +"\n- exportPDF button saves a vector file."
    );
    */
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    /*println("got an event from group "
      +theEvent.getGroup().getName()
      +", isOpen? "+theEvent.getGroup().isOpen()
      );*/
  } else if (theEvent.isController()) {
    /*println("got something from a controller "
      +theEvent.getController().getName()
      );*/
  }
  if (theEvent.isFrom(INTERFACES.getController("FontsList"))) {
    fontIndex = (int)d1.getValue();
    s = fontList[fontIndex];
    getFont = s;
  }
}
/////////////////////////////////////////////// Event listening


/* :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */

// Fonction pour mettre à jour notre grille
void updateGrid(float xOff, float yOff, float pasX, float pasY, float pasXDot, float pasYDot) {
  //updatePGraphics();
  DOT_AGENTS.renderGrid(xOff, yOff, pasX, pasY);
  LINE_AGENTS.renderGrid(xOff, yOff, pasXDot, pasYDot);
}

void updateTextField() {
  myTextfield.setText(getFont);
}

/* :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */

// Bang button updates
public void bangSave() {
  selectOutput("Save a preset", "fileSelectedOut");
}
public void bangLoad() {
  selectInput("Load a preset", "fileSelected");
}


public void bangExport() {
  SAVE_PDF = !SAVE_PDF;
}

// File Selection method for choosing saved presets
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String s = selection.getAbsolutePath();
    //INTERFACES.getProperties().load(s);
    INTERFACES.loadProperties(s);
  }
}

// File saving method for saving presets
void fileSelectedOut(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String s = selection.getAbsolutePath();
    INTERFACES.saveProperties(s);
  }
}

//////////////////// ADDED 25 : 01 : 2017
// function that will be called when controller 'numbers' changes
public void numbers(float f) {
  //println("received "+f+" from Numberbox numbers ");
}

void makeEditable( Numberbox n ) {
  // allows the user to click a numberbox and type in a number which is confirmed with RETURN
  final NumberboxInput nin = new NumberboxInput( n ); // custom input handler for the numberbox

  // control the active-status of the input handler when releasing the mouse button inside
  // the numberbox. deactivate input handler when mouse leaves.
  n.onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      nin.setActive( true );
    }
  }
  ).onLeave(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      nin.setActive( false );
      nin.submit();
    }
  }
  );
}



// input handler for a Numberbox that allows the user to
// key in numbers with the keyboard to change the value of the numberbox

public class NumberboxInput {

  String text = "";
  Numberbox n;
  boolean active;

  NumberboxInput(Numberbox theNumberbox) {
    n = theNumberbox;
    registerMethod("keyEvent", this );
  }

  public void keyEvent(KeyEvent k) {
    // only process key event if input is active
    if (k.getAction()==KeyEvent.PRESS && active) {
      if (k.getKey()=='\n') { // confirm input with enter
        submit();
        return;
      } else if (k.getKeyCode()==BACKSPACE) {
        text = text.isEmpty() ? "":text.substring(0, text.length()-1);
        //text = ""; // clear all text with backspace
      } else if (k.getKey()<255) {
        // check if the input is a valid (decimal) number
        final String regex = "\\d+([.]\\d{0,2})?";
        String s = text + k.getKey();
        if ( java.util.regex.Pattern.matches(regex, s ) ) {
          text += k.getKey();
        }
      }
      n.getValueLabel().setText(this.text);
    }
  }

  public void setActive(boolean b) {
    active = b;
    if (active) {
      n.getValueLabel().setText("");
      text = "";
    }
  }

  public void submit() {
    if (!text.isEmpty()) {
      n.setValue( float( text ) );
      text = "";
    } else {
      n.getValueLabel().setText(""+n.getValue());
    }
  }
}
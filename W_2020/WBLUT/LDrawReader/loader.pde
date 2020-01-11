//open file in one of the data dirs. mpd files will first be split in their component ldr files and saved in the models directory.

//File format
//https://www.ldraw.org/article/218.html

void load(String file) {
  if (file.substring(file.length()-3).toLowerCase().equals("mpd")) {
    mainFile=null;
    splitMPD(file);
  } else {
    mainFile=file;
  }
  condLines=new ArrayList<ConditionalLine>();
  model=createShape(GROUP);
  tris=createShape();
  quads=createShape();
  edges=createShape();
  tris.beginShape(TRIANGLES);
  tris.noStroke();
  quads.beginShape(QUADS);
  quads.noStroke();
  edges.beginShape(LINES);
  loadFile(mainFile, new M44(), 0, 0);
  tris.endShape();
  quads.endShape();
  edges.endShape();
  model.addChild(tris);
  model.addChild(quads);
}

void splitMPD(String file) {
  String[] MPD=null;
  for (String dir : dataDir) {
    if (Files.exists(Paths.get(dir+file))) {
      MPD=loadStrings(dir+file);
      break;
    }
  }
  
  int numberOfLines=(MPD==null)?0:MPD.length;

  PrintWriter sub=null;
  for (int i=0; i<numberOfLines; i++) {
    if (MPD[i].length()>6 && MPD[i].substring(0, 6).equals("0 FILE")) {
      if (sub!=null) {
        sub.flush();
        sub.close();
      }
      String[] tokens=splitTokens(MPD[i]);
      String subFile="";
      for (int j=2; j<tokens.length; j++) {
        subFile+=tokens[j];
      }
      if (mainFile==null) mainFile=subFile.toLowerCase();
      sub=createWriter(modelPath+subFile.toLowerCase());
    }
    if (sub!=null) {
      sub.println(MPD[i]);
    }
  }
  if (sub!=null) {
    sub.flush();
    sub.close();
  }
}

String loadFile(String file, M44 M, int colorId, int level) {
  for (String dir : dataDir) {
    if (Files.exists(Paths.get(dir+file))) {
      loadFileInt(dir+file, M, colorId, level);
      return dir;
    }
  }
  return "";
}

String findFile(String file) {
  for (String dir : dataDir) {
    if (Files.exists(Paths.get(dir+file))) {
      return dir;
    }
  }
  return "";
}

void loadFileInt(String file, M44 M, int colorId, int level) {
  String[] part=parts.get(file);
  if (part==null) {
    part=loadStrings(file);
    parts.put(file, part);
  }
  String[] tokens;
  float u, v, w, up, vp, wp;
  float x1, y1, z1;
  float x2, y2, z2;
  float tx1, ty1, tz1;
  float tx2, ty2, tz2;
  for (int j=0; j<part.length; j++) {
    if (part[j].length()>0) {
      tokens=splitTokens(part[j]);
      if (tokens.length==0) {
        //Comment or META Command
      } else if (tokens[0].equals("1")) {
        //Sub-file reference
        M44 Msub=new M44(float(tokens[2]), float(tokens[3]), float(tokens[4]), 
          float(tokens[5]), float(tokens[6]), float(tokens[7]), 
          float(tokens[8]), float(tokens[9]), float(tokens[10]), 
          float(tokens[11]), float(tokens[12]), float(tokens[13]));
        String subFile="";
        for (int i=14; i<tokens.length; i++) {
          subFile+=tokens[i];
        }
        int cId=(tokens[1].equals("16")||tokens[1].equals("24"))?colorId:int(tokens[1]);
        String found=findFile(subFile.toLowerCase());
      
          loadFile(subFile.toLowerCase(), Msub.mul(M), cId, level+1);
          println("Level "+(level+1)+": "+subFile+" "+found);
       
        
      } else if (tokens[0].equals("2")) {
        //Line
        int cId=(tokens[1].equals("24")||tokens[1].equals("16"))?colorId:int(tokens[1]);
        color col;
        try {
           col=tokens[1].equals("24")?edgeColors.get(colorId):tokens[1].equals("16")?colors.get(colorId):edgeColors.get(cId);
          col=color(red(col), green(col), blue(col), alpha.get(cId));
        }
        catch(Exception e) {
          col=color(255);
        }


        edges.stroke(col);
        u=float(tokens[2]);
        v=float(tokens[3]);
        w=float(tokens[4]);
        up=M.a*u+M.b*v+M.c*w+M.x;
        vp=M.d*u+M.e*v+M.f*w+M.y;
        wp=M.g*u+M.h*v+M.i*w+M.z;
        edges.vertex(up, vp, wp);
        u=float(tokens[5]);
        v=float(tokens[6]);
        w=float(tokens[7]);
        up=M.a*u+M.b*v+M.c*w+M.x;
        vp=M.d*u+M.e*v+M.f*w+M.y;
        wp=M.g*u+M.h*v+M.i*w+M.z;
        edges.vertex(up, vp, wp);
      } else if (tokens[0].equals("5")) {
        //Optional line
        int cId=(tokens[1].equals("24")||tokens[1].equals("16"))?colorId:int(tokens[1]);
        color col;
        try {
           col=tokens[1].equals("24")?edgeColors.get(colorId):tokens[1].equals("16")?colors.get(colorId):edgeColors.get(cId);
          col=color(red(col), green(col), blue(col), alpha.get(cId));
        }
        catch(Exception e) {
          col=color(255);
        }
        u=float(tokens[2]);
        v=float(tokens[3]);
        w=float(tokens[4]);
        x1=M.a*u+M.b*v+M.c*w+M.x;
        y1=M.d*u+M.e*v+M.f*w+M.y;
        z1=M.g*u+M.h*v+M.i*w+M.z;
        u=float(tokens[5]);
        v=float(tokens[6]);
        w=float(tokens[7]);
        x2=M.a*u+M.b*v+M.c*w+M.x;
        y2=M.d*u+M.e*v+M.f*w+M.y;
        z2=M.g*u+M.h*v+M.i*w+M.z;
        u=float(tokens[8]);
        v=float(tokens[9]);
        w=float(tokens[10]);
        tx1=M.a*u+M.b*v+M.c*w+M.x;
        ty1=M.d*u+M.e*v+M.f*w+M.y;
        tz1=M.g*u+M.h*v+M.i*w+M.z;
        u=float(tokens[11]);
        v=float(tokens[12]);
        w=float(tokens[13]);
        tx2=M.a*u+M.b*v+M.c*w+M.x;
        ty2=M.d*u+M.e*v+M.f*w+M.y;
        tz2=M.g*u+M.h*v+M.i*w+M.z;
        condLines.add(new ConditionalLine(x1, y1, z1, x2, y2, z2, tx1, ty1, tz1, tx2, ty2, tz2, col));
      } else if (tokens[0].equals("3")) {
        //Triangle
        int cId=(tokens[1].equals("24")||tokens[1].equals("16"))?colorId:int(tokens[1]);
        color  col;
        try {
           col=tokens[1].equals("24")?edgeColors.get(colorId):tokens[1].equals("16")?colors.get(colorId):colors.get(cId);
          col=color(red(col), green(col), blue(col), alpha.get(cId));
        }
        catch(Exception e) {
          col=color(255);
        }

        tris.fill(col);
        u=float(tokens[2]);
        v=float(tokens[3]);
        w=float(tokens[4]);
        up=M.a*u+M.b*v+M.c*w+M.x;
        vp=M.d*u+M.e*v+M.f*w+M.y;
        wp=M.g*u+M.h*v+M.i*w+M.z;
        tris.vertex(up, vp, wp);
        u=float(tokens[5]);
        v=float(tokens[6]);
        w=float(tokens[7]);
        up=M.a*u+M.b*v+M.c*w+M.x;
        vp=M.d*u+M.e*v+M.f*w+M.y;
        wp=M.g*u+M.h*v+M.i*w+M.z;
        tris.vertex(up, vp, wp);
        u=float(tokens[8]);
        v=float(tokens[9]);
        w=float(tokens[10]);
        up=M.a*u+M.b*v+M.c*w+M.x;
        vp=M.d*u+M.e*v+M.f*w+M.y;
        wp=M.g*u+M.h*v+M.i*w+M.z;
        tris.vertex(up, vp, wp);
      } else if (tokens[0].equals("4")) {
        //Quadrilateral
        int cId=(tokens[1].equals("24")||tokens[1].equals("16"))?colorId:int(tokens[1]);
        color  col;
        try {
           col=tokens[1].equals("24")?edgeColors.get(colorId):tokens[1].equals("16")?colors.get(colorId):colors.get(cId);
          col=color(red(col), green(col), blue(col), alpha.get(cId));
        }
        catch(Exception e) {
          col=color(255);
        }
        quads.fill(col);
        u=float(tokens[2]);
        v=float(tokens[3]);
        w=float(tokens[4]);
        up=M.a*u+M.b*v+M.c*w+M.x;
        vp=M.d*u+M.e*v+M.f*w+M.y;
        wp=M.g*u+M.h*v+M.i*w+M.z;
        quads.vertex(up, vp, wp);
        u=float(tokens[5]);
        v=float(tokens[6]);
        w=float(tokens[7]);
        up=M.a*u+M.b*v+M.c*w+M.x;
        vp=M.d*u+M.e*v+M.f*w+M.y;
        wp=M.g*u+M.h*v+M.i*w+M.z;
        quads.vertex(up, vp, wp);
        u=float(tokens[8]);
        v=float(tokens[9]);
        w=float(tokens[10]);
        up=M.a*u+M.b*v+M.c*w+M.x;
        vp=M.d*u+M.e*v+M.f*w+M.y;
        wp=M.g*u+M.h*v+M.i*w+M.z;
        quads.vertex(up, vp, wp);
        u=float(tokens[11]);
        v=float(tokens[12]);
        w=float(tokens[13]);
        up=M.a*u+M.b*v+M.c*w+M.x;
        vp=M.d*u+M.e*v+M.f*w+M.y;
        wp=M.g*u+M.h*v+M.i*w+M.z;
        quads.vertex(up, vp, wp);
      }
    }
  }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Runtime.Intrinsics.Arm;
using System.Text;
using System.Threading.Tasks;

namespace Bagnan1_AreaCalc
{
   public static class Bagnan1Calc
   {
      /// <summary>
      /// Description:
      /// 
      /// Dependencies:
      ///   InitScales
      /// </summary>
      private static double _scale_x = 0.0;
      public static double ScaleX 
      { 
         get
         {
            if(_scale_x < 1.0E-05) 
                  throw new Exception("ScaleX not initialised");

            return _scale_x;
         }

         set
         {
            if (value < 1.0E-05)
               throw new Exception("Cannot set ScaleX to less than 1.0E-05");

            _scale_x = value;
         }
      }

      /// <summary>
      /// Description:
      /// 
      /// Dependencies:
      ///   InitScales
      /// </summary>
      private static double _scale_y = 0.0;
      public static double ScaleY
      {
         get
         {
            if (_scale_y < 1.0E-05)
               throw new Exception("ScaleY not initialised");

            return _scale_y;
         }

         set
         {
            if (value < 1.0E-05)
               throw new Exception("Cannot set ScaleY to less than 1.0E-05");

            _scale_y = value;
         }
      }

      /// <summary>
      /// Description:
      /// 
      /// Dependencies: none
      /// 
      /// </summary>
      public static Dictionary<string, bool> InitStatusMap = new Dictionary<string, bool>()
      {
          { "Area_A_Calc"     , false}
         ,{ "Area_B_Calc"     , false}
         ,{ "Area_C_Calc"     , false}
         ,{ "Area_D_Calc"     , false}
         ,{ "Area_E_Calc"     , false}
         ,{ "Area_F_Calc"     , false}
         ,{ "Area_G_Calc"     , false}
         ,{ "Area_H_Calc"     , false}
         ,{ "AreaCalcM2"      , false}
         ,{ "CalcScales"      , false}
         ,{ "Init"            , false}
         ,{ "InitLengthsMap"  , false}
         ,{ "InitPolygonMap"  , false}
         ,{ "InitVertexMap"   , false}
         ,{ "InitZeroLengths" , false}
         ,{ "SectionAreaCalc" , false}
      };

      /// <summary>
      /// Description:
      /// data driven approch to checking preconditions (dependencies)
      /// key: fn, value = set of dependencies that must be completed
      /// 
      /// Dependencies: none
      /// 
      /// </summary>
      public static Dictionary<string, List<string>> InitDependenciesMap = new Dictionary<string, List<string>>()
      {
          { "Area_A_Calc"           , new List<string>(){"TriangleAreaCalc" }}
         ,{ "Area_B_Calc"           , new List<string>(){"TrapeziumAreaCalc"}}
         ,{ "Area_C_Calc"           , new List<string>(){"TrapeziumAreaCalc"}}
         ,{ "Area_D_Calc"           , new List<string>(){"TrapeziumAreaCalc"}}
         ,{ "Area_E_Calc"           , new List<string>(){"TrapeziumAreaCalc"}}
         ,{ "Area_F_Calc"           , new List<string>(){"TrapeziumAreaCalc"}}
         ,{ "Area_G_Calc"           , new List<string>(){"TrapeziumAreaCalc"}}
         ,{ "Area_H_Calc"           , new List<string>(){"TriangleAreaCalc" }}
         ,{ "AreaCalcM2"            , new List<string>(){"TrapeziumAreaCalc"}}
         ,{ "CalcScalesForEdge"     , new List<string>(){"InitVertexMap", "InitLengthsMap"}}
         ,{ "GetPolygonVertices"    , new List<string>(){"InitPolygons"}}
         ,{ "Init"                  , new List<string>()}   // no dependencies
         ,{ "InitLengthsMap"        , new List<string>()}   // no dependencies
         ,{ "InitPolygonMap"        , new List<string>()}   // no dependencies
         ,{ "InitScales"            , new List<string>(){"CalcScalesForEdge","InitVertexMap", "InitLengthsMap"}}
         ,{ "InitVertexMap"         , new List<string>()}   // no dependencies
         ,{ "GetXpx"                , new List<string>(){"InitVertexMap"}}
         ,{ "GetYpx"                , new List<string>(){"InitVertexMap"}}
         ,{ "GetXm"                 , new List<string>(){ "InitVertexMap", "InitScales" }}
         ,{ "GetYm"                 , new List<string>(){ "InitVertexMap", "InitScales" }}
         ,{ "InitZeroLengths"       , new List<string>() {"InitVertexMap", "InitLengthsMap", "InitScales"}}  // InitVertexMap, InitLengths, InitScales
         ,{ "SectionAreaCalc"       , new List<string>(){ 
              "InitScales"
            , "Area_A_Calc"
            , "Area_B_Calc"
            , "Area_C_Calc"
            , "Area_D_Calc"
            , "Area_E_Calc"
            , "Area_F_Calc"
            , "Area_G_Calc"
            , "Area_H_Calc"
           }}
         ,{ "TrapeziumAreaCalc"     , new List<string>()}
      };

      /// <summary>
      /// Description:
      ///   map of vertex id to x,y pixel  [x,y] coordinates
      /// 
      /// Dependencies:
      ///   InitVertexMap()
      ///   
      /// </summary>
      public static Dictionary<Char, (double, double)>  VertexMap = new();

      // Sequence of vertices in a polygon
      /// <summary>
      /// Dependencies:
      ///  InitPolygonMap()
      ///  
      /// </summary>
      public static Dictionary<Char, List<Char>> PolygonMap =new Dictionary<char, List<char>>();
      // lengtht of edges between vertices: measured lengths in meters

      /// <summary>
      /// Description:
      ///   holds the measured lengths in meters between adcaebnt vertices
      /// Dependencies:
      /// 
      /// </summary>
      public static Dictionary<Char, Dictionary<Char,double>> LengthMap = new Dictionary<char, Dictionary<char, double>>();

      /// <summary>
      ///
      /// /// POSTCONDITIONS:
      /// POST 01: ScaleX != 0
      /// POST 02: ScaleY != 0 (both are implemented in the ScaleX,Y accessors)
      /// POST 03: no edge length is zero
      /// </summary>
      public static void Init()
      {
         string fn = "Init";
         Console.WriteLine($"{fn}() starting");
         ChkDependencies(fn);
         InitVertexMap();
         InitPolygonMap();
         InitLengthsMap();
         InitScales();

         // Do this when InitLengths and InitScales completed
         InitZeroLengths();
         ChkInitPostConditions();
         SetFnStatus("Init");
         ChkInitComplete();

         Console.WriteLine($"{fn}() leaving");
      }

      public static void InitVertexMap()
      {
         string fn = "InitVertexMap";
         Console.WriteLine($"{fn}() starting");
         ChkDependencies(fn);
         VertexMap.Clear();

         VertexMap.Add('A', (1545,  434));
         VertexMap.Add('B', (1565,  106));
         VertexMap.Add('C', (1443,   54));
         VertexMap.Add('D', (1317,  194));
         VertexMap.Add('E', (1161,  202));
         VertexMap.Add('F', (1194,  387));
         VertexMap.Add('H', (1150,  475));
         VertexMap.Add('K', (1011,  500));
         VertexMap.Add('L', ( 950,  605));
         VertexMap.Add('M', (1436, 1140));
         VertexMap.Add('T', (1502,  608));
         VertexMap.Add('U', (1514,  500));
         VertexMap.Add('V', (1518,  475));
         VertexMap.Add('W', (1530,  387));
         VertexMap.Add('X', (1551,  202));
         VertexMap.Add('Y', (1552,  194));
         VertexMap.Add('Z', (1421,  106));
         SetFnStatus(fn);

         Console.WriteLine($"{fn}() leaving");
      }

      /// <summary>
      /// Desription:
      ///   initialises the PolygonMap with the respective seq of vertices in clockwise order starting top left
      /// PRECONDITIONS:
      /// Dependencies: none
      /// 
      /// POSTCONDITIONS:
      ///    PolygonMap initialised with the respective seq of vertices in clockwise order starting top left
      /// </summary>
      public static void InitPolygonMap()
      {
         string fn = "InitPolygonMap";
         Console.WriteLine($"{fn}() starting");
         ChkDependencies(fn);
         PolygonMap.Add('A', new List<char>() { 'C', 'B', 'Z' });
         PolygonMap.Add('B', new List<char>() { 'Z', 'B', 'Y', 'D' });
         PolygonMap.Add('C', new List<char>() { 'D', 'Y', 'X', 'E' });
         PolygonMap.Add('D', new List<char>() { 'E', 'X', 'W', 'F' });
         PolygonMap.Add('E', new List<char>() { 'F', 'W', 'V', 'H' });
         PolygonMap.Add('F', new List<char>() { 'H', 'V', 'U', 'K' });
         PolygonMap.Add('G', new List<char>() { 'K', 'U', 'T', 'L' });
         PolygonMap.Add('H', new List<char>() { 'L', 'T', 'M' });
         SetFnStatus(fn);

         Console.WriteLine($"{fn}() leaving");
      }

      /// <summary>
      /// Description:
      ///   initialises the lengths map
      ///   The length map is a map of vertex to map of adjacent vertex to the measured length between the 2 in meters
      ///   where lengths are not know length is set zeros will be estimated later from the drawing by InitZeroLengths()
      ///   
      /// PRECONDITIONS:
      /// Dependencies: 
      /// </summary>
      public static void InitLengthsMap()
      {
         string fn = "InitLengthsMap";
         Console.WriteLine($"{fn}() starting");
         ChkDependencies(fn);

         AddLength('A', 'B', 20);
         AddLength('A', 'M', 112);
         AddLength('B', 'Z', 0);
         AddLength('B', 'C', 39);

         AddLength('C', 'D', 65);
         AddLength('D', 'E', 14);
         AddLength('E', 'F', 39);
         AddLength('F', 'H', 140);

         AddLength('H', 'K', 20);
         AddLength('K', 'L', 32);
         AddLength('L', 'M', 123);

         AddLength('M', 'T', 0);
//         AddLength('M', 'L', 65);
         AddLength('T', 'U', 0);
         AddLength('T', 'K', 0);
         AddLength('U', 'V', 0);
         AddLength('U', 'H', 0);

         AddLength('V', 'W', 0);
         AddLength('W', 'X', 0);
         AddLength('W', 'F', 0);
         AddLength('X', 'Y', 0);
         AddLength('X', 'E', 0);
         AddLength('Y', 'B', 0);

         AddLength('Y', 'D', 0);

         SetFnStatus(fn);
         Console.WriteLine($"{fn}() leaving");
      }

      /// <summary>
      /// Do not expect the length to exist at the start of this rtn
      /// </summary>
      /// <param name="a"></param>
      /// <param name="b"></param>
      /// <param name="length"></param>
      public static void AddLength(char a, char b, int length)
      {        
         if(!LengthMap.Keys.Contains(a)) 
            LengthMap.Add(a, new Dictionary<Char, double>());

         LengthMap[a].Add(b, Convert.ToDouble(length));
      }

      /// <summary>
      /// POST 01: ScaleX != 0
      /// POST 02: ScaleY != 0 (both are implemented in the ScaleX,Y accessors)
      /// POST 03: no edge length is zero
      /// </summary>
      public static void ChkInitPostConditions()
      {
         string fn = "ChkInitPostConditions";
         Console.WriteLine($"{fn}() starting");
         /// POST 01: ScaleX != 0
         if (Convert.ToInt32(ScaleX) == 0) throw new Exception("ScaleX is zero");

         /// POST 02: ScaleY != 0 (both are implemented in the ScaleX,Y accessors)
         if (Convert.ToInt32(ScaleY) == 0) throw new Exception("ScalY is zero");

         /// POST 03: no edge length is zero
         ChkInitZeroLengthsPostConditions();
         Console.WriteLine($"{fn}() leaving");
      }

      /// <summary>
      /// check every length in the length map
      /// </summary>
      /// <exception cref="Exception"></exception>
      public static void ChkInitZeroLengthsPostConditions()
      {
         string fn = "ChkInitZeroLengthsPostConditions";
         Console.WriteLine($"{fn}() starting");

         /// POST 03: no edge length is zero
         foreach (KeyValuePair<char, Dictionary<char, double>> kvp_end_vertices in LengthMap)
         {
            char st_vertex_nm = kvp_end_vertices.Key;
            Dictionary<char, double> end_vertex_map = kvp_end_vertices.Value;

            foreach (KeyValuePair<char, double> kvpr in end_vertex_map)
            {
               if (Convert.ToInt32(kvpr.Value) == 0)
                  throw new Exception($"Error: Init() did not initialise unmeasured length {st_vertex_nm}-{kvpr.Key} from the drawing");
            }
         }

         Console.WriteLine($"{fn}() leaving");
      }

      /// <summary>
      /// Initialises the LengthMap map (meters) where the initial value is zero
      /// 
      /// PRECONDITIONS:
      /// Dependencies InitVertexMap, InitLengthsMap, InitScales
      /// 
      /// POST 01: no edge length is zero
      ///   LengthMap.Add('B', new Dictionary<char, double>() { { 'Z', 0.0 } });
      ///   LengthMap.Add('M', new Dictionary<char, double>() { { 'T', 0.0 } });
      ///   LengthMap.Add('T', new Dictionary<char, double>() { { 'U', 0.0 } });
      ///   LengthMap.Add('U', new Dictionary<char, double>() { { 'V', 0.0 } });
      ///   LengthMap.Add('V', new Dictionary<char, double>() { { 'W', 0.0 } });
      ///   LengthMap.Add('W', new Dictionary<char, double>() { { 'X', 0.0 } });
      ///   LengthMap.Add('X', new Dictionary<char, double>() { { 'Y', 0.0 } });
      ///   LengthMap.Add('Y', new Dictionary<char, double>() { { 'B', 0.0 } });
      /// </summary>
      public static void InitZeroLengths()
      {
         string fn = "InitZeroLengths";
         Console.WriteLine($"{fn}() starting");
         ChkDependencies(fn);

         foreach(var start_vertex in LengthMap.Keys)
         {
            Dictionary<char, double> end_vertices = LengthMap[start_vertex];

            foreach(var end_vertex in end_vertices.Keys)
            {
               double len = end_vertices[end_vertex];

               // estimate un measured lengths from drawing
               if(len < 1.0E-05)
                  end_vertices[end_vertex] = EstimateLengthFromDrawing(start_vertex, end_vertex);
            }
         }

         /// POST 01: no edge length is zero done in ChkInitPostConditions()
         ChkInitZeroLengthsPostConditions();
         SetFnStatus("InitZeroLengths");
         Console.WriteLine($"{fn}() leaving");
      }

      /// <summary>
      /// Description: estimates the length between to vertices in meters from the drawing.
      /// 
      /// Dependencies: GetXm():GetXpx(), VertexMap, InitScales, GetYm(): GetYpx(), 
      /// </summary>
      /// <param name="a"></param>
      /// <param name="b"></param>
      public static double EstimateLengthFromDrawing(char a, char b)
      {
         double dx; // in meters
         double dy;
         dx = DXpx(a, b);
         dy = DYpy(a, b);

         // Adjust to scale px->meters
         dx *= ScaleX;
         dy *= ScaleY;
         double len = Math.Sqrt(dx * dx + dy * dy);
         return len;
      }

      /// <summary>
      /// Calculate both x and Y scales as they can be different
      /// Select as many data as possible to get this info
      /// as mesuring pixels in paint is not accurate 
      /// AB, AM, BC, CD, ED, HK, LM 
      /// 
      /// RESPONSIBILITIES:
      /// Sets ScaleX 
      /// Sets ScaleY 
      /// 
      /// PRECONDITIONS (dependencies)
      ///   InitVertexMap, InitLengths
      /// 
      /// POSTCONDITIONS:
      /// POST 01: ScaleX != 0
      /// POST 02: ScaleY != 0 (both are implemented in the ScaleX,Y accessors)
      /// 
      /// Dependencies:
      ///   CalcScalesForEdge: VertexMap, InitVertexMap, InitLengthsMap
      /// </summary>
      public static void InitScales()
      {
         string fn = "InitScales";
         Console.WriteLine($"{fn}() starting");
         double t_dpx  = 0.0; // aggregated over all measured lengths
         double t_dpy  = 0.0; // aggregated over all measured lengths
         double t_mx   = 0.0; // local to vertex
         double t_my   = 0.0; // local to vertex
         double scaleX = 0.0; // local to vertex
         double scaleY = 0.0; // local to vertex

         CalcScalesForEdge('A', 'B', ref t_dpx, ref t_dpy, ref t_mx, ref t_my, ref scaleX, ref scaleY); // AB
         CalcScalesForEdge('A', 'M', ref t_dpx, ref t_dpy, ref t_mx, ref t_my, ref scaleX, ref scaleY); // AM
         CalcScalesForEdge('B', 'C', ref t_dpx, ref t_dpy, ref t_mx, ref t_my, ref scaleX, ref scaleY); // BC
         CalcScalesForEdge('C', 'D', ref t_dpx, ref t_dpy, ref t_mx, ref t_my, ref scaleX, ref scaleY); // CD
         CalcScalesForEdge('D', 'E', ref t_dpx, ref t_dpy, ref t_mx, ref t_my, ref scaleX, ref scaleY); // ED
         CalcScalesForEdge('H', 'K', ref t_dpx, ref t_dpy, ref t_mx, ref t_my, ref scaleX, ref scaleY); // HK
         CalcScalesForEdge('L', 'M', ref t_dpx, ref t_dpy, ref t_mx, ref t_my, ref scaleX, ref scaleY); // LM 

         double f = t_mx / t_dpx;
         ScaleX = f;
         f = t_my / t_dpy;
         ScaleY = f;
         SetFnStatus(fn);
         Console.WriteLine($"{fn}() leaving, ScaleX: {ScaleX} ScaleY: {ScaleY} ");
      }

      /// <summary>
      /// PRECONDITIONS:
      ///  Dependencies
      ///   VertexMap, InitVertexMap, LengthMap -> InitLengthsMap
      /// POSTCONDITIONS:
      /// POST 01: t_xm, t_ym all should go up in value, nothng should be negative
      /// POST 02: len_px between 2 vertices cannot be zero
      /// </summary>
      /// <param name="a"></param>
      /// <param name="b"></param>
      /// <param name="t_dpx"></param>
      /// <param name="t_dpy"></param>
      /// <param name="t_xm"></param>
      /// <param name="t_ym"></param>
      public static void CalcScalesForEdge(char a, char b, ref double t_dpx, ref double t_dpy, ref double t_xm, ref double t_ym, ref double scaleX, ref double scaleY)
      {
         string fn = "CalcScalesForEdge";
         Console.WriteLine($"{fn}() starting(a: {a}, b: {b}) starting");
         ChkDependencies("CalcScalesForEdge");
         double dpx = double.Abs(VertexMap[a].Item1 - VertexMap[b].Item1);
         double dpy = double.Abs(VertexMap[a].Item2 - VertexMap[b].Item2);


         double dm = double.Abs(LengthMap[a][b]);
         double len_px = Math.Sqrt(dpy * dpy + dpx * dpx);

         // POST 02: len_px between 2 vertices cannot be zero
         if (Convert.ToInt32(len_px) == 0)
            throw new Exception($"CalcScalesForEdge(a: {a}, b: {b}) len between 2 vertices cannot be zero");

         if (Convert.ToInt32(dm * 100) <= 0)
            throw new Exception($"CalcScalesForEdge(a: {a}, b: {b}) dm: {dm} is <= 0");


         //-------------------------------------------------------------------------------------
         // ASSERTION: len_px and dm are not zero
         //-------------------------------------------------------------------------------------
         double theta = Math.Atan(dpy / dpx); // radians
         double xm = dm * Math.Cos(theta);
         double ym = dm * Math.Sin(theta);

         // POST 01: t_xm, t_ym all should go up in value
         if (xm <= 0.0 || ym <= 0.0)
            throw new Exception($"CalcScalesForEdge( a: {a}, b: {b} t_dpx: {dpx}, t_dpy: {dpy}, t_xm: {xm}, t_ym: {ym} all should go up in value");

         t_dpx += dpx;
         t_dpy += dpy;
         t_xm += xm;
         t_ym += ym;
         scaleX = dpx / xm;
         scaleY = dpy / ym;
         Console.WriteLine($"{fn}() leaving, t_dpx:{t_dpx}, t_dpy:{t_dpy}, t_xm:{t_xm} t_ym:{t_ym}");
      }

      /// <summary>
      /// Decription: gets the sequence of vertex names for the given polygon in clockwise order
      /// 
      /// PRECONDITIONS
      /// Dependencies: InitPolygonMap: PolygonMap
      /// 
      ///  POSTCONDITIONS: 
      ///  PRE 01:PolygonMap initialised or exception: "PolygonMap not initialised"
      /// </summary>
      /// <param name="nm"></param>
      /// <returns></returns>
      /// <exception cref="Exception"></exception>
      public static List<char>? GetPolygonVertices(char nm)
      {
         string fn = "Init";
         Console.WriteLine($"{fn}() starting");
         ChkDependencies(fn);
         List<char>? vertices;

         //  PRE 01:PolygonMap initialised
         if(PolygonMap.Count == 0)
            throw new Exception("PolygonMap not initialised");

         bool b = PolygonMap.TryGetValue(nm, out vertices);

         if (!b)
            throw new Exception($"Polygon {nm} does not exist");

         Console.WriteLine($"{fn}() leaving, vertices: {vertices}");
         return vertices;
      }

      //   A	1545	435
      //   B	1565	106
      //   C	1443	54
      //   D	1317	197
      //   E	1317	207
      //   F	1158	390
      //   H	1153	478
      //   K	
      //   L   950	608
      //   M	1436	1138
      //   T	1502	608
      //   U	1514	503
      //   V	1518	477
      //   W	1530	390
      //   X	1551	207
      //   Y	1552	197
      //   Z	1421	106

      /// <summary>
      /// Returns the area of Bagnan 1 in Ha
      /// 
      /// Dependencies:
      ///   AreaCalcM2
      /// </summary>
      /// <returns></returns>
      public static double AreaCalcHa()
      {
         return AreaCalcM2() / 10000.0;
      }

      /// <summary>
      /// Returns the area of Bagnan 1 in M2
      /// Design see the Bagnan1 area drawing:
      ///   D:\Dev\Repos\Farming\Bagnan1_AreaCalc\
      /// and the spreadsheet  
      ///   D:\Dev\Repos\Farming\Bagnan1_AreaCalc\Bagnan1_AreaCalc.xlsx
      /// </summary>
      /// <returns>area in square meters</returns>
      /// 
      /// Dependencies:
      ///   SectionAreaCalc
      public static double AreaCalcM2()
      {
         string fn = "AreaCalcM2";
         Console.WriteLine($"{fn}() starting");
         double a = 0.0;

         a += SectionAreaCalc('A');
         a += SectionAreaCalc('B');
         a += SectionAreaCalc('C');
         a += SectionAreaCalc('D');
         a += SectionAreaCalc('E');
         a += SectionAreaCalc('F');
         a += SectionAreaCalc('G');
         a += SectionAreaCalc('H');

         SetFnStatus("");
         Console.WriteLine($"{fn}() leaving, area: {a} square meters");
         return a;
      }

      /// <summary>
      /// Description: calculates the area of a section (slice) of the total area
      /// 
      /// Dependencies:
      ///     Area_A_Calc
      ///     Area_B_Calc
      ///     Area_C_Calc
      ///     Area_D_Calc
      ///     Area_E_Calc
      ///     Area_F_Calc
      ///     Area_G_Calc
      ///     Area_H_Calc
      /// </summary>
      /// <param name="v"></param>
      /// <returns></returns>
      public static double SectionAreaCalc(char section_nm)
      {
         string fn = "SectionAreaCalc";
         double sectionArea = 0.0;
         Console.WriteLine($"{fn}(section:{section_nm}) starting");

         switch (char.ToUpper(section_nm))
         {
            case 'A': sectionArea = Area_A_Calc(); break;
            case 'B': sectionArea = Area_B_Calc(); break;
            case 'C': sectionArea = Area_C_Calc(); break;
            case 'D': sectionArea = Area_D_Calc(); break;
            case 'E': sectionArea = Area_E_Calc(); break;
            case 'F': sectionArea = Area_F_Calc(); break;
            case 'G': sectionArea = Area_G_Calc(); break;
            case 'H': sectionArea = Area_H_Calc(); break;
         }

         SetFnStatus(fn);
         Console.WriteLine($"{fn}() leaving, section ( {section_nm}) area: {sectionArea} square meters");
         return sectionArea;
      }

      /// <summary>
      /// dependencies TriangleAreaCalc
      /// </summary>
      /// <returns></returns>
      /// <exception cref="NotImplementedException"></exception>
      public static double Area_A_Calc() {var r = TriangleAreaCalc ('A'); SetFnStatus("Area_A_Calc"); return r;}   // CBZ
      public static double Area_B_Calc() {var r = TrapeziumAreaCalc('B'); SetFnStatus("Area_B_Calc"); return r;}   // ZBYD
      public static double Area_C_Calc() {var r = TrapeziumAreaCalc('C'); SetFnStatus("Area_C_Calc"); return r;}   // DYXE
      public static double Area_D_Calc() {var r = TrapeziumAreaCalc('D'); SetFnStatus("Area_D_Calc"); return r;}   // EXWF
      public static double Area_E_Calc() {var r = TrapeziumAreaCalc('E'); SetFnStatus("Area_E_Calc"); return r;}   // FWVH
      public static double Area_F_Calc() {var r = TrapeziumAreaCalc('F'); SetFnStatus("Area_F_Calc"); return r;}   // HVUK
      public static double Area_G_Calc() {var r = TrapeziumAreaCalc('G'); SetFnStatus("Area_G_Calc"); return r;}   // KUTL
      public static double Area_H_Calc() {var r = TriangleAreaCalc ('H'); SetFnStatus("Area_H_Calc"); return r;}   // LTM

      /// <summary>
      /// Validate params
      /// Get the 3 vertices
      /// SectionAreaCalc= B*h/2
      /// base = delta x, ht = delta y
      /// 
      /// Dependencies: InitPolygonMap, GetPolygonVertices()
      /// </summary>
      /// <param name="s">section name</param>
      /// <returns>area</returns>
      /// <exception cref="NotImplementedException"></exception>
      public static double TriangleAreaCalc(char section)
      {
         string fn = "Init";
         Console.WriteLine($"{fn}(section:  {section}) starting");
         ChkDependencies(fn);
         List<char> polygon = (GetPolygonVertices(section) ?? new List<char>()) ?? throw new Exception($"polygon {section} not found");

         if (polygon.Count != 3)
            throw new($"TriangleAreaCalc(section: [{section}]) expects expects a triangle section, {polygon.Count}");

         double area = 0.0;
         // [0]=top [1]=bottom right [2]=bottom left 
         double b = DXm( polygon[1], polygon[2]);
         double h = DYm( polygon[0], polygon[1]);
         area = b*h/2.0;
         Console.WriteLine($"TriangleArea( {section}) leaving, area: {area} square meters");
         return area;
      }

      /// <summary>
      /// Validate params
      /// Get the 4 vertices
      /// TrapeziumAreaCalc= (Base+ top/2)* Ht
      /// 
      /// PRECONDITIONS: 
      /// Dependencies: GetPolygonVertices, InitPolygons, InitScales
      /// </summary>
      /// <param name="vertices">expect vertices in anti clockwise order starting top left </param>
      /// <returns></returns>
      public static double TrapeziumAreaCalc(char section) // string vertices
      {
         string fn = "TrapeziumAreaCalc";
         Console.WriteLine($"{fn}() starting");
         List<char> polygon = (GetPolygonVertices(section) ?? new List<char>()) ?? throw new Exception($"polygon {section} not found");

         if (polygon.Count != 4)
            throw new("TriangleArea expects 4 vertices");

         double dxTop = DXm(polygon[0], polygon[1]);
         double dxBot = DXm(polygon[2], polygon[3]);
         double dy    = DYm(polygon[0], polygon[2]);
         // TrapeziumAreaCalc= (Base+ top/2)* Ht
         double area = (dxTop+ dxBot)* dy/2.0;
         Console.WriteLine($"{fn}( {section}) leaving, area(m2): {area}");
         return area;
      }

      /// <summary>
      /// Gets the pixel X length between 2 verticies
      /// </summary>
      /// <param name="v1"></param>
      /// <param name="v2"></param>
      /// <returns></returns>
      public static double DXpx(char v1, char v2)
      {
         string fn = "DXpx";
         Console.WriteLine($"{fn}({v1}, {v2}) starting");
         double v1px = GetXpx(v1);
         double v2px = GetXpx(v2);
         double r = double.Abs(v2px - v2px);
         Console.WriteLine($"{fn}({v1}, {v2}) leaving, result: {r}");
         return r;
      }

      /// <summary>
      /// Gets the pixel Y length between 2 verticies
      /// </summary>
      /// <param name="v1"></param>
      /// <param name="v2"></param>
      /// <returns></returns>
      public static double DYpy(char v1, char v2)
      {
         string fn = "DeltaYpx";
         Console.WriteLine($"{fn}({v1}, {v2}) starting");
         double v1px = GetYpx(v1);
         double v2px = GetYpx(v2);
         double r = double.Abs(v2px - v2px);
         Console.WriteLine($"{fn}({v1}, {v2}) leaving, result: {r}");
         return r;
      }


      /// <summary>
      /// Description: gets the delta x in meters between 2 adjacent vertices
      /// Dependencies: GetXm()
      /// </summary>
      /// <param name="v1"></param>
      /// <param name="v2"></param>
      /// <returns></returns>
      public static double DXm(char v1, char v2)
      {
         string fn = "TrapeziumAreaCalc";
         Console.WriteLine($"{fn}({v1}, {v2}) starting");
         double v1x = GetXm(v1);
         double v2x = GetXm(v2);
         double r = double.Abs(v2x- v1x);
         Console.WriteLine($"{fn}({v1}, {v2}) leaving, result: {r}");
         return r;
      }

      /// <summary>
      /// Description: gets the delta y in meters between 2 adjacent vertices
      /// 
      /// Dependencies: GetYm()
      /// </summary>
      /// <param name="v1"></param>
      /// <param name="v2"></param>
      /// <returns></returns>
      public static double DYm(char v1, char v2)
      {
         string fn = "DeltaYM";
         Console.WriteLine($"{fn}( {v1}, {v2}) starting");
         ChkDependencies(fn);
         double v1y = GetYm(v1);
         double v2y = GetYm(v1);
         double r = double.Abs(v2y - v1y);
         Console.WriteLine($"{fn}( {v1}, {v2}) leaving, r: {r}");
         return r;
      }

      /// <summary>
      /// Description
      /// 
      /// Dependencies: InitVertexMap, InitScales
      ///   
      /// </summary>
      /// <param name="v"></param>
      /// <returns></returns>
      private static double GetXm(char v)
      {
         string fn = "GetXm";
         ChkDependencies(fn);
         return GetXpx(v) * ScaleX;
      }

      /// <summary>
      /// Description
      /// 
      /// Dependencies: InitVertexMap, InitScales
      /// </summary>
      /// <param name="v"></param>
      /// <returns></returns>
      private static double GetYm(char v)
      {
         string fn = "GetYm";
         ChkDependencies(fn);
         return GetYpx(v) * ScaleY;
      }

      /// <summary>
      /// Description
      /// 
      /// Dependencies: InitVertexMap
      /// </summary>
      /// <param name="v"></param>
      /// <returns></returns>
      private static double GetXpx(char v)
      {
         string fn = "GetXpx";
         ChkDependencies(fn);
         return VertexMap[v].Item1;
      }

      /// <summary>
      /// Description
      /// Description
      ///   
      /// 
      /// Dependencies
      ///   InitVertexMap
      /// </summary>
      /// <param name="v"></param>
      /// <returns></returns>
      private static double GetYpx(char v)
      {
         string fn = "GetYpx";
         ChkDependencies(fn);
         return VertexMap[v].Item2;
      }

      /// <summary>
      /// Description
      /// part of the initialisation system 
      /// this guarantees the dependencies are met for a the supplied fn 
      /// 
      /// Dependencies
      /// </summary>
      /// <exception cref="Exception"></exception>
      private static void ChkDependencies(string fn)
      {
         List<string> dependencies = InitDependenciesMap[fn];

         foreach (var dependency in dependencies)
         {
            if (InitStatusMap[dependency] == false)
               throw new Exception($"fn {fn} has an incomplete dependency: {dependency}");
         }
      }

      /// <summary>
      /// Description
      /// 
      /// Dependencies
      /// 
      /// </summary>
      /// <exception cref="Exception"></exception>
      private static void ChkInitComplete()
      {
         foreach (var kvpr in InitStatusMap)
         {
            if (kvpr.Value == false)
               throw new Exception($"fn {kvpr} not completed");
         }
      }

      /// <summary>
      /// Init helper fumnction 
      /// used in conjunction with the dependency tree
      /// and the ChkDependencies function
      /// 
      /// Primarily used to determined state is initialised properly before a function is called.
      /// </summary>
      /// <param name="fn"></param>
      public static void SetFnStatus(string fn)
      {
         InitStatusMap[fn] = true;
      }
   }
}

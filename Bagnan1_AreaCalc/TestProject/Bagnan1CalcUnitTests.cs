namespace TestProject
{
   using Bagnan1_AreaCalc;

   /// <summary>
   /// This is the main tet class for Bagnan1Calc
   /// </summary>
   [TestClass]
   public class Bagnan1CalcUnitTests
   {

      /// <summary>
      /// TriangleAreaCalc Dependencies: 
      /// Init:
      /// InitPolygonMap, InitVertexMap, ScaleX
      /// 
      /// </summary>
      [TestMethod]
      public void TestTriangleAreaCalc_green()
      {
         Bagnan1Calc.Init();
         double act = Bagnan1Calc.TriangleAreaCalc('A');
         Assert.AreEqual(240, act);
      }

      [TestMethod]
      public void TestTrapeziumAreaCalc()
      {
         // Check some known lengths first
         Bagnan1Calc.Init();

         // Check section D
         // vertices: EXWF
         var vertices = Bagnan1Calc.GetPolygonVertices('E');
         string vs = vertices?.ToString() ?? "";
         Console.WriteLine($"Section D vertices: {vs}");
         //Assert.AreEqual
      }

      [TestMethod]
      public void TestEstimateLengthFromDrawing()
      {
         // Check some known lengths first
         Bagnan1Calc.Init();
         double act = Bagnan1Calc.EstimateLengthFromDrawing('B','Z');
         //double exp = ;
      }

      /// <summary>
      /// Dependencies: InitVertexMap, InitLengthsMap, InitScales
      /// </summary>
      [TestMethod]
      public void TestInitZeroLengths()
      {
         try
         {
            // Do the minimal init
            Bagnan1Calc.InitLengthsMap();

            // Run the tested rtn
            Bagnan1Calc.InitZeroLengths();

            // test the results:
            InitZeroLengthsHlpr('B', 'Z');
            InitZeroLengthsHlpr('M', 'T');
            InitZeroLengthsHlpr('T', 'U');
            InitZeroLengthsHlpr('U', 'V');
            InitZeroLengthsHlpr('W', 'X');
            InitZeroLengthsHlpr('X', 'Y');
            InitZeroLengthsHlpr('Y', 'B');
         }
         catch (Exception e)
         {
            Console.WriteLine($"TestInitZeroLengths()  caught exception: e.Message: {e.Message}");
            Assert.AreEqual(e.Message, "Cannot set ScaleX to 0.0");
            throw;
         }
      }

      protected void InitZeroLengthsHlpr(char a, char b)
      {
         Assert.IsTrue(Bagnan1Calc.LengthMap.TryGetValue(a, out var values), $"a index not present in MeasuredLengthsMap[{a}][{b}]");
         Assert.IsTrue(values.TryGetValue(b, out var length), $"b index not present in MeasuredLengthsMap[{a}][{b}]");
         Assert.IsTrue(length > 5.0, $"MeasuredLengthsMap[{a}][{b}] < 5.0");
      }

      private void ChkDoubleMatch(double exp, double act)
      {
         double epsilon = 1.0E-5;
         Assert.IsTrue(double.Abs(act - exp) > epsilon, $"Expected {exp} but act: {act}");
      }

      /// <summary>
      /// Dependencies: InitVertexMap, InitLengths
      /// </summary>
      [TestMethod]
      public void TestInitScales()
      {
         try
         {
            Bagnan1Calc.InitVertexMap();
            Bagnan1Calc.InitLengthsMap();

            Bagnan1Calc.InitScales();
         }
         catch (Exception e)
         {
            Console.WriteLine($"TestInitScales() caught exception: e.Message: {e.Message}");
            Assert.AreEqual(e.Message, "Cannot set ScaleX to 0.0");
            throw;
         }
      }

      /// <summary>
      /// Dependencies: InitVertexMap, InitLengths
      /// </summary>
      [TestMethod]
      public void TestCalcScalesForEdge_does_not_go_up_in_value()
      {
         double t_dpx = 0, t_dpy = 0, t_xm = 0, t_ym = 0;
         double scaleX = 0.0; // local to vertex
         double scaleY = 0.0;

         try
         {
            Bagnan1Calc.InitVertexMap();
            Bagnan1Calc.InitLengthsMap();
            //Bagnan1Calc.InitScales();
            Bagnan1Calc.CalcScalesForEdge('B','C',ref t_dpx, ref t_dpy, ref t_xm, ref t_ym, ref scaleX, ref scaleY);
         }
         catch (Exception e)
         {
            Console.WriteLine($"TestCalcScalesForEdge_does_not_go_up_in_value() caught exception: e.Message: {e.Message}");
            Assert.AreEqual("Cannot set ScaleX to 0.0", e.Message);
            Console.WriteLine("TestCalcScalesForEdge_does_not_go_up_in_value() oops!");
            throw;
         }
      }

      [TestMethod]
      [ExpectedException(typeof(Exception), "oops")]
      public void TestScaleX_when_set_zero_expect_exception()
      {
         try { Bagnan1Calc.ScaleX = 0.0; }
         catch (Exception e)
         {
            Console.WriteLine($"TestScaleX_when_set_zero_expect_exception() caught exception: e.Message: {e.Message}");

            Assert.AreEqual(e.Message, "Cannot set ScaleX to 0.0");
            throw;
         }
      }

      [TestMethod]
      [ExpectedException(typeof(Exception), "oops")]
      public void TestScaleY_when_set_zero_expect_exception()
      {
         try { Bagnan1Calc.ScaleX = 0.0; }
         catch (Exception e)
         {
            Console.WriteLine($"TestScaleY_when_set_zero_expect_exception() caught exception: e.Message: {e.Message}");
            Assert.AreEqual(e.Message, "Cannot set ScaleY to 0.0");
            throw;
         }
      }

      /// <summary>
      /// test post condition: exception when PolygonVertices not init strategy 
      /// </summary>
      [TestMethod]
      [ExpectedException(typeof(Exception), "PolygonMap not initialised")]
      public void TestGetPolygonVertices_when_not_init()
      {
         //Bagnan1Calc.Init();
         double exp = Bagnan1Calc.TriangleAreaCalc('A');
         Assert.AreEqual(325, exp);
      }
      [TestMethod]
      public void TestInit()
      {
         Bagnan1Calc.Init();

         List<char>? polygon = Bagnan1Calc.GetPolygonVertices('A');
         CheckVerticesHlpr('A', "CBZ");
         CheckVerticesHlpr('B', "ZBYD");
         CheckVerticesHlpr('C', "DYXE");
         CheckVerticesHlpr('D', "EXWF");
         CheckVerticesHlpr('E', "FWVH");
         CheckVerticesHlpr('F', "HVUK");
         CheckVerticesHlpr('G', "KUTL");
         CheckVerticesHlpr('H', "LTM");
      }

      [TestMethod]
      public void TestInitVertices()
      {
         Bagnan1Calc.InitVertexMap();
         Bagnan1Calc.InitPolygonMap();

         List<char>? polygon = Bagnan1Calc.GetPolygonVertices('A');
         CheckVerticesHlpr('A', "CBZ");
         CheckVerticesHlpr('B', "ZBYD");
         CheckVerticesHlpr('C', "DYXE");
         CheckVerticesHlpr('D', "EXWF");
         CheckVerticesHlpr('E', "FWVH");
         CheckVerticesHlpr('F', "HVUK");
         CheckVerticesHlpr('G', "KUTL");
         CheckVerticesHlpr('H', "LTM");
      }

      [TestMethod]
      public void TestGetPolygonVertices()
      {
         Bagnan1Calc.Init();
         List<char>? polygon = Bagnan1Calc.GetPolygonVertices('A');
         CheckVerticesHlpr('A', "CBZ");
         CheckVerticesHlpr('B', "ZBYD");
         CheckVerticesHlpr('C', "DYXE");
         CheckVerticesHlpr('D', "EXWF");
         CheckVerticesHlpr('E', "FWVH");
         CheckVerticesHlpr('F', "HVUK");
         CheckVerticesHlpr('G', "KUTL");
         CheckVerticesHlpr('H', "LTM");
      }

      protected void CheckVerticesHlpr(char section_nm, string exp)
      {
         Assert.IsNotNull(exp);
         List<char>  expList = exp.ToList<char>();
         List<char>? actList = Bagnan1Calc.GetPolygonVertices(section_nm);
         Assert.IsNotNull(actList, "actList is NULL");
         Assert.AreEqual (expList.Count, actList.Count);
         //Assert.IsTrue   (expList == act);
         char exp_char;
         char act_char;
         
         for(int i=0; i< expList.Count; i++)
         {
            exp_char = expList[i];
            act_char = actList[i];

            if (exp_char != act_char)
               Assert.Fail($"mismatch in section: [{section_nm}], exp_char: [{exp_char}], act_char: [{act_char}]");
         }
      }
   }
}
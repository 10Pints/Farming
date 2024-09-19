using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bagnan1_AreaCalc
{
   public interface ITree
   {
      string GetName();
   }

   /// <summary>
   /// Generic tree construct
   /// supporting the following functionality
   ///   AddChild()
   ///   Traverse()
   /// </summary>
   /// <typeparam name="T"></typeparam>
   public class Tree<T> : IEnumerable<Tree<T>>, IEnumerator<Tree<T>>
   {

      Tree<T>? Parent { get; set; }  = null;
      String Name {get;set;}
      T Item {get; set; }
      string Node_ty_nm {get; set; }
      Tree<T>? FirstChild  { get; set; } = null; // pointer to left most child of node
      Tree<T>? NextSibling { get; set; } = null; // pointer to the sibling to the right

      public Tree<T> Current {get;set;}

      object IEnumerator.Current => this;

      /// <summary>
      /// POSTCONDITIONS:
      ///  POST 01: Exactly 1 of {parent and node_ty_nm} should not be null or exception "exactly 1 of {parent and node_ty_nm} should not be null (not both or neither)"
      ///  POST 02: name must not be null or empty  -> exception "Name must be specified"
      /// </summary>
      /// <param name="name"></param>
      /// <param name="item"></param>
      /// <param name="parent"></param>
      /// <param name="node_ty_nm"></param>
      public Tree( string name, T item, Tree<T>? parent, string? node_ty_nm = null)
      {
         Current = this;
         //----------------------------------------------------
         // Validation
         //----------------------------------------------------

         //  POST 01: Exactly 1 of {parent and node_ty_nm} should not be null or exception "exactly 1 of {parent and node_ty_nm} should not be null (not both or neither)"
         if (((parent == null) && (node_ty_nm == null)) || ((parent != null) && (node_ty_nm != null)))
               throw new Exception("Exactly 1 of {parent and node_ty_nm} should not be null (not both or neither)");

         //  POST 02: name must not be null or empty  -> exception "Name must be specified"
         if (string.IsNullOrEmpty(name))
            throw new Exception("Name must be specified");

         //----------------------------------------------------
         // Assertion: Validation passed
         // Process
         //----------------------------------------------------

         Node_ty_nm = node_ty_nm ?? "";
         Name = name;
         Item = item;
         
      }

      public void AddChild(string name, T item, string parent_nm)
      { 
         Tree<T>? parent_node = FindNode(parent_nm);
            
         if(parent_node == null)
            throw new Exception($"Tree.AddNode(parent node: {parent_nm}): error parent {Node_ty_nm} not found");

         //----------------------------------------------------
         // ASSERTION: parent node found
         //----------------------------------------------------

         var node = new Tree<T>(Node_ty_nm, item, this, Node_ty_nm);

         if( FirstChild == null)
            FirstChild = node;
         else FirstChild.AddSibling(node);
      }

      public void AddSibling(Tree<T> node)
      {
         // skip to end of family
         var last_sibling = this;

         for(Tree<T>? sibling = NextSibling; sibling != null; sibling = sibling.NextSibling)
            last_sibling = sibling;

         last_sibling.NextSibling = node;
      }

      public IEnumerator<Tree<T>> GetEnumerator()
      {
         yield return this;

         if (FirstChild != null)
            yield return FirstChild;

         if (NextSibling != null)
            yield return NextSibling;
      }

      IEnumerator IEnumerable.GetEnumerator()
      {
         yield return this;

         if (FirstChild != null)
            yield return FirstChild;

         if (NextSibling != null)
            yield return NextSibling;
      }

      /// <summary>
      /// Traverses the tree at this node DFS
      /// </summary>
      public void Traverse(int depth = 0)
      {
         string tab = new string(' ', depth*3);
         Console.WriteLine($"{tab} {this.Name}");

         if( FirstChild != null)
            FirstChild.Traverse(depth+1);

         if(NextSibling != null)
            NextSibling.Traverse(depth);
      }

      private Tree<T>? FindNode(string node_nm, bool must_exist=true)
      {
         Tree<T> ? node = null;

         do
         { 
            if (Item?.ToString()?.Equals(node_nm) ?? false) 
            {
               node = this;
               break;
            }

            if(FirstChild != null)
            {
               node = FirstChild.FindNode(node_nm);

               if(node != null)
                  break;
            }

            if (NextSibling != null)
            {
               node = NextSibling.FindNode(node_nm);

               if (node != null)
                  break;
            }

            // ASSERTION: if here then node not found
            if(must_exist == true)
               throw new Exception($"{Node_ty_nm}: {node_nm} does not exist in the tree");

         } while (false);

         return node;

      }

      public bool MoveNext()
      {
         bool ret = true;

         do 
         { 
            if(FirstChild != null)
            {   
               Current = FirstChild;
               break;
            }

            if (NextSibling != null)
            {
               Current = NextSibling;
               break;
            }

            // ASSERTION: if here then no more
         } while (false);

         return ret;
      }

      public void Reset()
      {
         Current = this;
      }

      public void Dispose()
      {
      }
   }
}

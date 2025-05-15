using System.Text;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis;

namespace RSDK;

[AttributeUsage(AttributeTargets.Class)]
public class RSDK_IMPLAttribute : Attribute;

[AttributeUsage(AttributeTargets.Struct)]
public class RegisterObjectAttribute : Attribute;

[Generator]
public class RegisterObjectGenerator : ISourceGenerator
{
    public void Initialize(GeneratorInitializationContext context) { }

    public void Execute(GeneratorExecutionContext context)
    {
        var syntax = new SyntaxWalker();
        foreach (var tree in context.Compilation.SyntaxTrees)
        {
            syntax.Visit(tree.GetRoot());
        }

        var builder = new StringBuilder();
        builder.AppendLine("using System;");
        builder.AppendLine("using System.Collections.Generic;");
        builder.AppendLine("namespace RSDK;");

        builder.AppendLine("public static unsafe class Generated");
        builder.AppendLine("{");
        builder.AppendLine("    public static readonly List<Type> Types = new List<Type>");
        builder.AppendLine("    {");
        foreach (var className in syntax.list)
        {
            builder.AppendLine($"        typeof(global::{className}),");
        }
        builder.AppendLine("    };");
        builder.AppendLine("    public static void InitGameLogic()");
        builder.AppendLine("    {");
        foreach (var className in syntax.list)
        {
            builder.AppendLine($"        DelegateTypes.TakesVoidPtr create = data => (({className}*)sceneInfo->entity)->Create(data);");
            builder.AppendLine($"        Action draw = () => (({className}*)sceneInfo->entity)->Draw();");
            builder.AppendLine($"        Action update = () => (({className}*)sceneInfo->entity)->Update();");
            builder.AppendLine($"        Action lateupdate = () => (({className}*)sceneInfo->entity)->LateUpdate();");
            builder.AppendLine($"        GameObject.Register<{className}, {className}.Static>(ref {className}.sVars, create, draw, update, lateupdate);");
        }
        builder.AppendLine("    }");
        builder.AppendLine("}");
        context.AddSource("Generated.g.cs", builder.ToString());
    }

    public class SyntaxWalker : CSharpSyntaxWalker
    {
        public List<string> list { get; } = new();

        public override void VisitStructDeclaration(StructDeclarationSyntax node)
        {
            foreach (AttributeListSyntax attributes in node.AttributeLists)
            {
                foreach (AttributeSyntax attribute in attributes.Attributes)
                {
                    if (attribute.Name.ToString() == "RegisterObject" || attribute.Name.ToString().EndsWith(".RegisterObject"))
                    {
                        string name = node.Identifier.Text;
                        if (NodeNamespace(node) != null)
                            name = $"{NodeNamespace(node)}.{name}";
                        list.Add(name);
                    }
                }
            }

            base.VisitStructDeclaration(node);
        }

        public static string? NodeNamespace(SyntaxNode? node)
        {
            while (node != null)
            {
                switch (node)
                {
                    case NamespaceDeclarationSyntax n:
                        return n.Name.ToString();
                    case FileScopedNamespaceDeclarationSyntax f:
                        return f.Name.ToString();
                }
                node = node.Parent;
            }
            return null;
        }
    }
}
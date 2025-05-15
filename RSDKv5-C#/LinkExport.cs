using System.Text;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis;

namespace RSDK;

[Generator]
public class LinkExportGenerator : ISourceGenerator
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
        builder.AppendLine("using System.Runtime.InteropServices;");
        builder.AppendLine("namespace RSDK;");
        builder.AppendLine("public static unsafe class LinkExports {");
        foreach (var className in syntax.list)
        {
            builder.AppendLine($"[UnmanagedCallersOnly(EntryPoint = \"LinkGameLogicDLL\")]");
#if RETRO_REV02
            builder.AppendLine($"private static void __linked_dll_g(EngineInfo* info) {{");
            builder.AppendLine($"    InitEngineInfo(*info);");
            builder.AppendLine($"    Generated.InitGameLogic();");
            builder.AppendLine($"    {className}.LinkGameLogic(*info);");
            builder.AppendLine("}");
#else
            builder.AppendLine($"private static void __linked_dll_g(EngineInfo info) {{");
            builder.AppendLine($"   InitEngineInfo(info);");
            builder.AppendLine($"   Generated.InitGameLogic();");
            builder.AppendLine($"   {className}.LinkGameLogic(info);");
            builder.AppendLine("}");
#endif

            builder.AppendLine($"[UnmanagedCallersOnly(EntryPoint = \"LinkModLogic\")]");
            builder.AppendLine($"private static bool32 __linked_dll_m(EngineInfo* info, char* id) {{");
            builder.AppendLine($"    InitEngineInfo(*info);");
            builder.AppendLine($"    Generated.InitGameLogic();");
            builder.AppendLine($"    {className}.LinkGameLogic(*info);");
            builder.AppendLine($"    return {className}.LinkModLogic(*info, new(id));");
            builder.AppendLine("}");
        }
        builder.AppendLine("}");
        context.AddSource("LinkExports.g.cs", builder.ToString());
    }

    public class SyntaxWalker : CSharpSyntaxWalker
    {
        public List<string> list { get; } = new();
        private bool hasImplementation = false;

        public override void VisitClassDeclaration(ClassDeclarationSyntax node)
        {
            foreach (AttributeListSyntax attributes in node.AttributeLists)
            {
                foreach (AttributeSyntax attribute in attributes.Attributes)
                {

                    if (attribute.Name.ToString() == "RSDK_IMPL" || attribute.Name.ToString().EndsWith(".RSDK_IMPL"))
                    {
                        if (hasImplementation)
                            return;

                        hasImplementation = true;

                        string name = node.Identifier.Text;
                        if (RegisterObjectGenerator.SyntaxWalker.NodeNamespace(node) != null)
                            name = $"{RegisterObjectGenerator.SyntaxWalker.NodeNamespace(node)}.{name}";

                        var hasLinkGameLogicMethod = node.Members.OfType<MethodDeclarationSyntax>()
                            .Any(m => m.Identifier.Text == "LinkGameLogic");

                        if (hasLinkGameLogicMethod)
                            list.Add(name);
                    }
                }
            }

            base.VisitClassDeclaration(node);
        }
    }
}
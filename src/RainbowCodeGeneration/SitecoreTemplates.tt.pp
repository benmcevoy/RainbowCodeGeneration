﻿<#@ template debug="false" hostspecific="true" language="C#" #>
<#@ output extension=".cs" #>
<#@ assembly name="System.Core" #>
<# // NOTE - Reference your NuGet packages for Rainbow and RainbowCodeGeneration here #>
<#@ assembly name="$(SolutionDir)packages\Rainbow.Core.1.3.1\lib\net45\Rainbow.dll" #>
<#@ assembly name="$(SolutionDir)packages\Rainbow.Storage.Yaml.1.3.1\lib\net45\Rainbow.Storage.Yaml.dll" #>
<#@ assembly name="$(SolutionDir)packages\RainbowCodeGeneration.0.1.1\lib\net45\RainbowCodeGeneration.dll" #>
<# // NOTE - Reference your Sitecore.Kernel.dll here #>
<#@ assembly name="$(SolutionDir)lib\Sitecore\Sitecore.Kernel.dll" #>
<# 
// CONFIGURATION
var physicalFileStore = @"..\serialization"; // the path to your serialisation items
var treeName = "YOUR FEATURE NAME HERE"; // the name of the configuration you want to code-generate 
var treePath = "/sitecore/templates/YOUR TEMPLATE PATH HERE"; // the matching path in Sitecore for the configuration

var Tool = "RainbowCodeGeneration";
var ToolVersion = "1.0";
var templates = RainbowCodeGeneration.RainbowReader.GetTemplates(Host.ResolvePath(physicalFileStore), treeName, treePath);
#>
<#@ import namespace="RainbowCodeGeneration" #>
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated based on the Unicorn serialisation items
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------
// ReSharper disable InconsistentNaming
namespace $rootnamespace$
{
	using global::Sitecore.Data;

	[global::System.CodeDom.Compiler.GeneratedCodeAttribute("<#=Tool#>", "<#=ToolVersion#>")]
    public struct SitecoreTemplates
    {
	<# foreach (var template in templates) { #>

		/// <summary>
		/// <#= template.Item.Name #>
		/// <para><#= template.Item.GetSharedField("__Short description") #></para>
		/// <para>Path: <#= template.Item.Path #></para>	
		/// <para>ID: <#= template.Item.Id #></para>	
		/// </summary>
		[global::System.CodeDom.Compiler.GeneratedCodeAttribute("<#=Tool#>", "<#=ToolVersion#>")]
		public struct <#= StringExtensions.AsClassName(template.Item.Name) #>
        {
			/// <summary>
			/// The ID for <#= template.Item.Path #>
			/// </summary>
			[global::System.CodeDom.Compiler.GeneratedCodeAttribute("<#=Tool#>", "<#=ToolVersion#>")]
            public static ID Id = new ID("{<#= template.Item.Id #>}");
			/// <summary>
			/// The TemplateId string for <#= template.Item.Path #>
			/// </summary>
			[global::System.CodeDom.Compiler.GeneratedCodeAttribute("<#=Tool#>", "<#=ToolVersion#>")]
			public const string TemplateId = "<#= template.Item.Id #>";
<# foreach (var field in template.Fields) { #>

			public struct <#= StringExtensions.AsClassName(field.Name) #>
            {
				/// <summary>
				/// The <#=field.Name#> field.
				/// <para><#= field.GetSharedField("__Short description")#></para>
				/// <para>Field Type: <#= field.GetSharedField("Type")#></para>		
				/// </summary>
                public const string FieldName = "<#= field.Name #>";
            }
<#  } // foreach field #>
		}
<#  } // foreach template #>
	}
}
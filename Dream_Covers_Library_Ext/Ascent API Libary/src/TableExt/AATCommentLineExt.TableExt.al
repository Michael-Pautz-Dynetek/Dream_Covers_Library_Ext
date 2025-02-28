/// <summary>
/// TableExtension AAT Comment Line Ext (ID 80100) extends Record Comment Line.
/// </summary>
tableextension 80100 "AAT Comment Line Ext" extends "Comment Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if ("Table Name" = const(API)) "AAT API";
        }
    }
}

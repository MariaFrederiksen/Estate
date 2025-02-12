pageextension 50037 "SVA Budget Ext" extends Budget
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(ReportTrialBalance)
        {

            action(Budgetreport)
            {
                Caption = 'Budget report';
                ToolTip = 'Report with balance movement and budget in the date delimitation, as well as budget for the whole year.';
                ApplicationArea = all;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                
                trigger OnAction()
                begin
                    Report.Run(Report::"SVA Trial Balance/Budget");
                end;

            }
        }
    }
    var
       

}
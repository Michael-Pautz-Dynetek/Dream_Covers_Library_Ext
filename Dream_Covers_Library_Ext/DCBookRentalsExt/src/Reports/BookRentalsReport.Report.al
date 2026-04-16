report 50426 "Book Rentals Report"
{
    Caption = 'Book Rentals Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout=RDLC;


    dataset
    {
        dataitem(Library; Library)
        {

            column(AmountRented_Library; "Amount Rented")
            {
            }
            column(AmountRentedLastMonth_Library; "Amount Rented Last Month")
            {
            }
            column(Author_Library; Author)
            {
            }
            column(BookNo_Library; "Book No.")
            {
            }
            column(BookPrice_Library; "Book Price")
            {
            }
            column(CustomerName_Library; "Customer Name")
            {
            }
            column(CustomerNo_Library; "Customer No.")
            {
            }
            column(DateAdded_Library; "Date Added")
            {
            }
            column(DateRented_Library; "Date Rented")
            {
            }
            column(Genre_Library; Genre)
            {
            }
            column(OverdueLevel_Library; "Overdue Level")
            {
            }
            column(Pages_Library; Pages)
            {
            }
            column(Prequel_Library; Prequel)
            {
            }
            column(PrequelID_Library; "Prequel ID")
            {
            }
            column(PublicationDate_Library; "Publication Date")
            {
            }
            column(Publisher_Library; Publisher)
            {
            }
            column(Rented_Library; Rented)
            {
            }
            column(RentedRank_Library; "Rented Rank")
            {
            }
            column(Sequel_Library; Sequel)
            {
            }
            column(Series_Library; Series)
            {
            }
            column(SystemCreatedAt_Library; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy_Library; SystemCreatedBy)
            {
            }
            column(SystemId_Library; SystemId)
            {
            }
            column(SystemModifiedAt_Library; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy_Library; SystemModifiedBy)
            {
            }
            column(Title_Library; Title)
            {
            }
            column(WeeksOverdue_Library; "Weeks Overdue")
            {
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
    }
}
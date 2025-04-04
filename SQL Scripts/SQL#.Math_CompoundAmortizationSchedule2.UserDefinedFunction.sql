SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Math_CompoundAmortizationSchedule2](@LoanAmount [money], @AnnualInterestRate [decimal](8, 5), @YearsOfLoan [int], @PaymentsPerYear [int], @LoanStartDate [datetime], @OptionalExtraPayment [money], @UseStandardRounding [bit])
RETURNS  TABLE (
	[PaymentNum] [int] NULL,
	[PaymentDate] [datetime] NULL,
	[BeginningBalance] [money] NULL,
	[ScheduledPayment] [money] NULL,
	[ExtraPayment] [money] NULL,
	[TotalPayment] [money] NULL,
	[Principal] [money] NULL,
	[Interest] [money] NULL,
	[EndingBalance] [money] NULL,
	[CumulativeInterest] [money] NULL,
	[TotalInterest] [money] NULL,
	[TotalPayments] [int] NULL,
	[PaymentsLeft] [int] NULL,
	[CumulativePrincipal] [money] NULL,
	[CumulativeAmountPaid] [money] NULL,
	[TotalAmountPaid] [money] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[MATH].[CompoundAmortizationSchedule2]
GO

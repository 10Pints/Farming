SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [SQL#].[Math_CompoundAmortizationSchedule](@LoanAmount [float], @AnnualInterestRate [float], @YearsOfLoan [int], @PaymentsPerYear [int], @LoanStartDate [datetime], @OptionalExtraPayment [float])
RETURNS  TABLE (
	[PaymentNum] [int] NULL,
	[PaymentDate] [datetime] NULL,
	[BeginningBalance] [float] NULL,
	[ScheduledPayment] [float] NULL,
	[ExtraPayment] [float] NULL,
	[TotalPayment] [float] NULL,
	[Principal] [float] NULL,
	[Interest] [float] NULL,
	[EndingBalance] [float] NULL,
	[CumulativeInterest] [float] NULL,
	[TotalInterest] [float] NULL,
	[TotalPayments] [int] NULL,
	[PaymentsLeft] [int] NULL,
	[CumulativePrincipal] [float] NULL,
	[CumulativeAmountPaid] [float] NULL,
	[TotalAmountPaid] [float] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SQL#].[MATH].[CompoundAmortizationSchedule]
GO

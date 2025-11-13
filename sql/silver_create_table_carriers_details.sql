USE [AirtravelSilver]
GO

/****** Object:  Table [dbo].[Carriers_Details]    Script Date: 04-11-25 09:58:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Carriers_Details](
	[SK_ID] [int] IDENTITY(1,1) NOT NULL,
	[BK_ID] [nvarchar](20) NOT NULL,
	[AIRLINE_ID] [int] NOT NULL,
	[CARRIER] [nvarchar](3) NULL,
	[CARRIER_NAME] [nvarchar](200) NOT NULL,
	[UNIQUE_CARRIER] [nvarchar](10) NULL,
	[UNIQUE_CARRIER_ENTITY] [nvarchar](10) NOT NULL,
	[UNIQUE_CARRIER_NAME] [nvarchar](200) NOT NULL,
	[WAC] [int] NOT NULL,
	[CARRIER_GROUP] [tinyint] NOT NULL,
	[CARRIER_GROUP_NEW] [tinyint] NOT NULL,
	[REGION_LONG] [nvarchar](50) NOT NULL,
	[REGION] [nchar](1) NOT NULL,
	[START_DATE_SOURCE] [datetime2](7) NOT NULL,
	[THRU_DATE_SOURCE] [datetime2](7) NULL,
	[FK_CARRIER_ID] [int] NULL,
 CONSTRAINT [PK_Carriers_Details] PRIMARY KEY CLUSTERED 
(
	[SK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Carriers_Details]  WITH CHECK ADD  CONSTRAINT [FK_Carriers_Details_Carriers] FOREIGN KEY([FK_CARRIER_ID])
REFERENCES [dbo].[Carriers] ([SK_UNIQUE_ID])
GO

ALTER TABLE [dbo].[Carriers_Details] CHECK CONSTRAINT [FK_Carriers_Details_Carriers]
GO



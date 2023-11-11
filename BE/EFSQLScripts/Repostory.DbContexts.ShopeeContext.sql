IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [BranchStore] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NOT NULL,
        [Image] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_BranchStore] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [City] (
        [Id] nvarchar(10) NOT NULL,
        [NameCity] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_City] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [User] (
        [Id] nvarchar(50) NOT NULL,
        [Username] nvarchar(100) NOT NULL,
        [PasswordHash] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_User] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [District] (
        [Id] nvarchar(10) NOT NULL,
        [NameDistrict] nvarchar(100) NOT NULL,
        [IdCity] nvarchar(10) NOT NULL,
        CONSTRAINT [PK_District] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_District_City] FOREIGN KEY ([IdCity]) REFERENCES [City] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [Information] (
        [Id] nvarchar(50) NOT NULL,
        [FullName] nvarchar(255) NOT NULL,
        [Email] nvarchar(255) NOT NULL,
        [PhoneNumber] nvarchar(max) NOT NULL,
        [Image] nvarchar(11) NOT NULL,
        [Address] nvarchar(255) NOT NULL,
        [Dob] datetime2 NOT NULL,
        [UserId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Information] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Information_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [RefeshToken] (
        [RefeshToken] nvarchar(50) NOT NULL,
        [Expires] datetime2 NOT NULL,
        [CreatedTime] datetime2 NOT NULL,
        [UserId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_RefeshToken] PRIMARY KEY ([RefeshToken]),
        CONSTRAINT [FK_RefeshToken_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [Ward] (
        [Id] nvarchar(10) NOT NULL,
        [NameWard] nvarchar(100) NOT NULL,
        [IdDistict] nvarchar(10) NOT NULL,
        CONSTRAINT [PK_Ward] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Ward_District] FOREIGN KEY ([IdDistict]) REFERENCES [District] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [CategoryConsumpType] (
        [Id] nvarchar(50) NOT NULL,
        [Title] nvarchar(max) NOT NULL,
        [IdWard] nvarchar(10) NOT NULL,
        CONSTRAINT [PK_CategoryConsumpType] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_CategoryConsumpType_Ward] FOREIGN KEY ([IdWard]) REFERENCES [Ward] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [Collection] (
        [Id] nvarchar(50) NOT NULL,
        [Title] nvarchar(max) NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [Image] nvarchar(max) NOT NULL,
        [IdWard] nvarchar(10) NOT NULL,
        CONSTRAINT [PK_Collection] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Collections_Ward] FOREIGN KEY ([IdWard]) REFERENCES [Ward] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [ConsumpType] (
        [Id] nvarchar(50) NOT NULL,
        [Title] nvarchar(100) NOT NULL,
        [IdCategoryConsumpType] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_ConsumpType] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ConsumpType_CateogoryConsumptype] FOREIGN KEY ([IdCategoryConsumpType]) REFERENCES [CategoryConsumpType] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [Store] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(max) NOT NULL,
        [Image] nvarchar(max) NOT NULL,
        [OpenTime] time NOT NULL,
        [CloseTime] time NOT NULL,
        [Address] nvarchar(max) NOT NULL,
        [IsDeal] bit NOT NULL,
        [TagDeals] nvarchar(max) NULL,
        [IdBranchStore] nvarchar(50) NOT NULL,
        [IdCollection] nvarchar(50) NOT NULL,
        [IdConsumpType] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Store] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Store_BranchStore] FOREIGN KEY ([IdBranchStore]) REFERENCES [BranchStore] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Store_Collection] FOREIGN KEY ([IdCollection]) REFERENCES [Collection] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Store_ConsumpType] FOREIGN KEY ([IdConsumpType]) REFERENCES [ConsumpType] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [Cart] (
        [Id] nvarchar(50) NOT NULL,
        [UserId] nvarchar(50) NOT NULL,
        [IdStore] nvarchar(50) NOT NULL,
        [TotalPrice] float NOT NULL,
        [Status] int NOT NULL,
        [DeliveryAddress] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Cart] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Cart_Store] FOREIGN KEY ([IdStore]) REFERENCES [Store] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Cart_User] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [CategoryProduct] (
        [Id] nvarchar(50) NOT NULL,
        [Title] nvarchar(100) NOT NULL,
        [IdStore] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_CategoryProduct] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_CategoryProduct_Store] FOREIGN KEY ([IdStore]) REFERENCES [Store] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [Product] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(250) NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [Image] nvarchar(max) NOT NULL,
        [Price] float NOT NULL,
        [IdCategoryProduct] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Product] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Product_CategoryProduct] FOREIGN KEY ([IdCategoryProduct]) REFERENCES [CategoryProduct] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE TABLE [DetailsCart] (
        [Id] nvarchar(50) NOT NULL,
        [IdCart] nvarchar(50) NOT NULL,
        [Quantity] int NOT NULL,
        [Price] float NOT NULL,
        [IdProduct] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_DetailsCart] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DetailsCart_Cart] FOREIGN KEY ([IdCart]) REFERENCES [Cart] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_DetailsCart_Product] FOREIGN KEY ([IdProduct]) REFERENCES [Product] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_Cart_IdStore] ON [Cart] ([IdStore]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_Cart_UserId] ON [Cart] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_CategoryConsumpType_IdWard] ON [CategoryConsumpType] ([IdWard]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_CategoryProduct_IdStore] ON [CategoryProduct] ([IdStore]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_Collection_IdWard] ON [Collection] ([IdWard]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_ConsumpType_IdCategoryConsumpType] ON [ConsumpType] ([IdCategoryConsumpType]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_DetailsCart_IdCart] ON [DetailsCart] ([IdCart]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_DetailsCart_IdProduct] ON [DetailsCart] ([IdProduct]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_District_IdCity] ON [District] ([IdCity]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE UNIQUE INDEX [IX_Information_UserId] ON [Information] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_Product_IdCategoryProduct] ON [Product] ([IdCategoryProduct]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE UNIQUE INDEX [IX_RefeshToken_UserId] ON [RefeshToken] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_Store_IdBranchStore] ON [Store] ([IdBranchStore]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_Store_IdCollection] ON [Store] ([IdCollection]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_Store_IdConsumpType] ON [Store] ([IdConsumpType]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    CREATE INDEX [IX_Ward_IdDistict] ON [Ward] ([IdDistict]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025035908_initdatabase')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231025035908_initdatabase', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025040257_initdatabase1')
BEGIN
    EXEC sp_rename N'[Ward].[IdDistict]', N'IdDistrict', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025040257_initdatabase1')
BEGIN
    EXEC sp_rename N'[Ward].[IX_Ward_IdDistict]', N'IX_Ward_IdDistrict', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025040257_initdatabase1')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231025040257_initdatabase1', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025065712_updateTableInformation')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'Image');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [Information] ALTER COLUMN [Image] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025065712_updateTableInformation')
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'Address');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [Information] ALTER COLUMN [Address] nvarchar(255) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025065712_updateTableInformation')
BEGIN
    ALTER TABLE [Information] ADD [Gender] nvarchar(5) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025065712_updateTableInformation')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231025065712_updateTableInformation', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025070047_UpdateTableRefeshToken')
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'RefeshToken');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [RefeshToken] ALTER COLUMN [RefeshToken] nvarchar(450) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025070047_UpdateTableRefeshToken')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231025070047_UpdateTableRefeshToken', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [FK_CategoryConsumpType_Ward];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    ALTER TABLE [Collection] DROP CONSTRAINT [FK_Collections_Ward];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    EXEC sp_rename N'[Collection].[IdWard]', N'IdCity', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    EXEC sp_rename N'[Collection].[IX_Collection_IdWard]', N'IX_Collection_IdCity', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    EXEC sp_rename N'[CategoryConsumpType].[IdWard]', N'IdCity', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    EXEC sp_rename N'[CategoryConsumpType].[IX_CategoryConsumpType_IdWard]', N'IX_CategoryConsumpType_IdCity', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    ALTER TABLE [Store] ADD [IdWard] nvarchar(10) NOT NULL DEFAULT N'';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    CREATE INDEX [IX_Store_IdWard] ON [Store] ([IdWard]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    ALTER TABLE [CategoryConsumpType] ADD CONSTRAINT [FK_CategoryConsumpType_City] FOREIGN KEY ([IdCity]) REFERENCES [City] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    ALTER TABLE [Collection] ADD CONSTRAINT [FK_Collections_City] FOREIGN KEY ([IdCity]) REFERENCES [City] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    ALTER TABLE [Store] ADD CONSTRAINT [FK_Store_Ward] FOREIGN KEY ([IdWard]) REFERENCES [Ward] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025084955_updatedatabase')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231025084955_updatedatabase', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025150400_UpdateDatabaseCategoryConsumptType_Collections')
BEGIN
    ALTER TABLE [Collection] DROP CONSTRAINT [FK_Collections_City];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025150400_UpdateDatabaseCategoryConsumptType_Collections')
BEGIN
    DROP INDEX [IX_Collection_IdCity] ON [Collection];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025150400_UpdateDatabaseCategoryConsumptType_Collections')
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'IdCity');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var3 + '];');
    ALTER TABLE [Collection] DROP COLUMN [IdCity];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025150400_UpdateDatabaseCategoryConsumptType_Collections')
BEGIN
    ALTER TABLE [Collection] ADD [IdCategoryConsumpType] nvarchar(50) NOT NULL DEFAULT N'';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025150400_UpdateDatabaseCategoryConsumptType_Collections')
BEGIN
    CREATE INDEX [IX_Collection_IdCategoryConsumpType] ON [Collection] ([IdCategoryConsumpType]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025150400_UpdateDatabaseCategoryConsumptType_Collections')
BEGIN
    ALTER TABLE [Collection] ADD CONSTRAINT [FK_Collections_CategoryconsumpType] FOREIGN KEY ([IdCategoryConsumpType]) REFERENCES [CategoryConsumpType] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231025150400_UpdateDatabaseCategoryConsumptType_Collections')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231025150400_UpdateDatabaseCategoryConsumptType_Collections', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Ward] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Ward] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5962160+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Ward] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [User] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [User] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5959436+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [User] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Store] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Store] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5945924+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Store] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var4 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-10-26T09:07:09.5943401+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Product] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Product] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5936176+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Product] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Information] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Information] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5933940+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Information] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [District] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [District] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5929550+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [District] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [DetailsCart] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [DetailsCart] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5922356+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [DetailsCart] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [ConsumpType] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [ConsumpType] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5917191+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [ConsumpType] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Collection] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Collection] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5912074+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Collection] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [City] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [City] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5909370+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [City] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [CategoryProduct] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [CategoryProduct] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5904161+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [CategoryProduct] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [CategoryConsumpType] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [CategoryConsumpType] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5898053+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [CategoryConsumpType] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Cart] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Cart] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5891023+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [Cart] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [BranchStore] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [BranchStore] ADD [CreatedTime] datetime2 NOT NULL DEFAULT '2023-10-26T09:07:09.5887806+07:00';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    ALTER TABLE [BranchStore] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026020709_AddIsDelete_CreatedTime_CreatedBy')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231026020709_AddIsDelete_CreatedTime_CreatedBy', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var5 sysname;
    SELECT @var5 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var5 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-10-26T22:21:46.3340178+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var6 sysname;
    SELECT @var6 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var6 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-10-26T22:21:46.3338212+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var7 sysname;
    SELECT @var7 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var7 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-10-26T22:21:46.3327982+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var8 sysname;
    SELECT @var8 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var8 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-10-26T22:21:46.3325989+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    ALTER TABLE [RefeshToken] ADD [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    ALTER TABLE [RefeshToken] ADD [Id] nvarchar(50) NULL DEFAULT N'e887e588_f';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    ALTER TABLE [RefeshToken] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var9 sysname;
    SELECT @var9 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var9 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-10-26T22:21:46.3320054+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var10 sysname;
    SELECT @var10 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var10 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-10-26T22:21:46.3318594+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var11 sysname;
    SELECT @var11 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var11 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-10-26T22:21:46.3315448+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var12 sysname;
    SELECT @var12 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var12 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-10-26T22:21:46.3310278+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var13 sysname;
    SELECT @var13 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var13 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var13 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-10-26T22:21:46.3306613+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var14 sysname;
    SELECT @var14 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var14 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var14 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-10-26T22:21:46.3302919+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var15 sysname;
    SELECT @var15 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var15 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var15 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-10-26T22:21:46.3301124+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var16 sysname;
    SELECT @var16 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var16 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var16 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-10-26T22:21:46.3297466+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var17 sysname;
    SELECT @var17 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var17 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var17 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-10-26T22:21:46.3293258+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var18 sysname;
    SELECT @var18 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var18 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var18 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-10-26T22:21:46.3288153+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    DECLARE @var19 sysname;
    SELECT @var19 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var19 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var19 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-10-26T22:21:46.3285584+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026152146_UpdateTableRefeshToken1')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231026152146_UpdateTableRefeshToken1', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var20 sysname;
    SELECT @var20 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var20 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var20 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-10-26T22:39:27.1378103+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var21 sysname;
    SELECT @var21 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var21 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var21 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-10-26T22:39:27.1376515+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var22 sysname;
    SELECT @var22 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var22 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var22 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-10-26T22:39:27.1366064+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var23 sysname;
    SELECT @var23 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'Id');
    IF @var23 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var23 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT N'e23e8832_2' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var24 sysname;
    SELECT @var24 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var24 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var24 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-10-26T22:39:27.1364051+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var25 sysname;
    SELECT @var25 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var25 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var25 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-10-26T22:39:27.1358304+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var26 sysname;
    SELECT @var26 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var26 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var26 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-10-26T22:39:27.1356578+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var27 sysname;
    SELECT @var27 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var27 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var27 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-10-26T22:39:27.1352709+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var28 sysname;
    SELECT @var28 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var28 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var28 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-10-26T22:39:27.1345575+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var29 sysname;
    SELECT @var29 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var29 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var29 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-10-26T22:39:27.1340969+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var30 sysname;
    SELECT @var30 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var30 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var30 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-10-26T22:39:27.1336752+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var31 sysname;
    SELECT @var31 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var31 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var31 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-10-26T22:39:27.1334430+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var32 sysname;
    SELECT @var32 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var32 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var32 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-10-26T22:39:27.1330293+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var33 sysname;
    SELECT @var33 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var33 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var33 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-10-26T22:39:27.1325910+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var34 sysname;
    SELECT @var34 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var34 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var34 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-10-26T22:39:27.1320464+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    DECLARE @var35 sysname;
    SELECT @var35 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var35 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var35 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-10-26T22:39:27.1317852+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026153927_UpdateTableUser')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231026153927_UpdateTableUser', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    ALTER TABLE [RefeshToken] DROP CONSTRAINT [FK_RefeshToken_User_UserId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DROP INDEX [IX_RefeshToken_UserId] ON [RefeshToken];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var36 sysname;
    SELECT @var36 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var36 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var36 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-10-26T22:41:52.6919517+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var37 sysname;
    SELECT @var37 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var37 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var37 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-10-26T22:41:52.6916756+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var38 sysname;
    SELECT @var38 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var38 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var38 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-10-26T22:41:52.6898128+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var39 sysname;
    SELECT @var39 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'Id');
    IF @var39 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var39 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT N'18138d85_9' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var40 sysname;
    SELECT @var40 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var40 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var40 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-10-26T22:41:52.6893499+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var41 sysname;
    SELECT @var41 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var41 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var41 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-10-26T22:41:52.6875176+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var42 sysname;
    SELECT @var42 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var42 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var42 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-10-26T22:41:52.6869979+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var43 sysname;
    SELECT @var43 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var43 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var43 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-10-26T22:41:52.6861612+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var44 sysname;
    SELECT @var44 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var44 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var44 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-10-26T22:41:52.6848889+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var45 sysname;
    SELECT @var45 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var45 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var45 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-10-26T22:41:52.6840368+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var46 sysname;
    SELECT @var46 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var46 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var46 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-10-26T22:41:52.6831267+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var47 sysname;
    SELECT @var47 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var47 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var47 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-10-26T22:41:52.6826660+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var48 sysname;
    SELECT @var48 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var48 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var48 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-10-26T22:41:52.6817038+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var49 sysname;
    SELECT @var49 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var49 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var49 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-10-26T22:41:52.6806085+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var50 sysname;
    SELECT @var50 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var50 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var50 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-10-26T22:41:52.6792909+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    DECLARE @var51 sysname;
    SELECT @var51 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var51 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var51 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-10-26T22:41:52.6783663+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026154152_UpdateTableUser1')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231026154152_UpdateTableUser1', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    ALTER TABLE [RefeshToken] DROP CONSTRAINT [PK_RefeshToken];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var52 sysname;
    SELECT @var52 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var52 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var52 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-10-26T23:00:09.8114081+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var53 sysname;
    SELECT @var53 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var53 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var53 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-10-26T23:00:09.8112327+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var54 sysname;
    SELECT @var54 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var54 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var54 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-10-26T23:00:09.8100886+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var55 sysname;
    SELECT @var55 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'Id');
    IF @var55 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var55 + '];');
    EXEC(N'UPDATE [RefeshToken] SET [Id] = N''5d0239b1_5'' WHERE [Id] IS NULL');
    ALTER TABLE [RefeshToken] ALTER COLUMN [Id] nvarchar(50) NOT NULL;
    ALTER TABLE [RefeshToken] ADD DEFAULT N'5d0239b1_5' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var56 sysname;
    SELECT @var56 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var56 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var56 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-10-26T23:00:09.8099784+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var57 sysname;
    SELECT @var57 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'RefeshToken');
    IF @var57 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var57 + '];');
    ALTER TABLE [RefeshToken] ALTER COLUMN [RefeshToken] nvarchar(max) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var58 sysname;
    SELECT @var58 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var58 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var58 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-10-26T23:00:09.8093718+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var59 sysname;
    SELECT @var59 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var59 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var59 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-10-26T23:00:09.8092036+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var60 sysname;
    SELECT @var60 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var60 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var60 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-10-26T23:00:09.8088547+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var61 sysname;
    SELECT @var61 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var61 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var61 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-10-26T23:00:09.8082637+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var62 sysname;
    SELECT @var62 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var62 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var62 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-10-26T23:00:09.8078645+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var63 sysname;
    SELECT @var63 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var63 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var63 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-10-26T23:00:09.8074574+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var64 sysname;
    SELECT @var64 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var64 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var64 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-10-26T23:00:09.8072535+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var65 sysname;
    SELECT @var65 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var65 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var65 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-10-26T23:00:09.8068418+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var66 sysname;
    SELECT @var66 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var66 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var66 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-10-26T23:00:09.8063667+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var67 sysname;
    SELECT @var67 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var67 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var67 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-10-26T23:00:09.8057685+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    DECLARE @var68 sysname;
    SELECT @var68 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var68 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var68 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-10-26T23:00:09.8054688+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    ALTER TABLE [RefeshToken] ADD CONSTRAINT [PK_RefeshToken] PRIMARY KEY ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231026160009_UpdateTableRefeshToken2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231026160009_UpdateTableRefeshToken2', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    ALTER TABLE [RefeshToken] DROP CONSTRAINT [PK_RefeshToken];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var69 sysname;
    SELECT @var69 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var69 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var69 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-10-27T08:51:50.1781233+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var70 sysname;
    SELECT @var70 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var70 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var70 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-10-27T08:51:50.1778321+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var71 sysname;
    SELECT @var71 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var71 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var71 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-10-27T08:51:50.1762052+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var72 sysname;
    SELECT @var72 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'RefeshToken');
    IF @var72 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var72 + '];');
    ALTER TABLE [RefeshToken] ALTER COLUMN [RefeshToken] nvarchar(450) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var73 sysname;
    SELECT @var73 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var73 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var73 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-10-27T08:51:50.1760356+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var74 sysname;
    SELECT @var74 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'Id');
    IF @var74 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var74 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT N'0cdb93e2_3' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var75 sysname;
    SELECT @var75 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var75 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var75 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-10-27T08:51:50.1746949+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var76 sysname;
    SELECT @var76 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var76 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var76 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-10-27T08:51:50.1744121+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var77 sysname;
    SELECT @var77 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var77 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var77 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-10-27T08:51:50.1739086+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var78 sysname;
    SELECT @var78 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var78 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var78 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-10-27T08:51:50.1729902+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var79 sysname;
    SELECT @var79 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var79 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var79 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-10-27T08:51:50.1723283+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var80 sysname;
    SELECT @var80 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var80 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var80 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-10-27T08:51:50.1716083+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var81 sysname;
    SELECT @var81 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var81 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var81 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-10-27T08:51:50.1711905+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var82 sysname;
    SELECT @var82 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var82 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var82 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-10-27T08:51:50.1703371+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var83 sysname;
    SELECT @var83 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var83 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var83 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-10-27T08:51:50.1695246+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var84 sysname;
    SELECT @var84 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var84 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var84 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-10-27T08:51:50.1686215+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    DECLARE @var85 sysname;
    SELECT @var85 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var85 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var85 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-10-27T08:51:50.1682524+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    ALTER TABLE [RefeshToken] ADD CONSTRAINT [PK_RefeshToken] PRIMARY KEY ([Id], [RefeshToken], [UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    CREATE UNIQUE INDEX [IX_RefeshToken_UserId] ON [RefeshToken] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    ALTER TABLE [RefeshToken] ADD CONSTRAINT [FK_RefeshToken_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015150_UpdateRefeshTokenPrimaryKey')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231027015150_UpdateRefeshTokenPrimaryKey', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var86 sysname;
    SELECT @var86 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var86 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var86 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-10-27T08:57:37.9204870+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var87 sysname;
    SELECT @var87 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var87 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var87 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-10-27T08:57:37.9202447+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var88 sysname;
    SELECT @var88 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var88 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var88 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-10-27T08:57:37.9189756+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var89 sysname;
    SELECT @var89 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var89 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var89 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-10-27T08:57:37.9187933+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var90 sysname;
    SELECT @var90 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'Id');
    IF @var90 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var90 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT N'd1281ee6_2' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var91 sysname;
    SELECT @var91 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var91 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var91 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-10-27T08:57:37.9177641+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var92 sysname;
    SELECT @var92 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var92 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var92 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-10-27T08:57:37.9175439+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var93 sysname;
    SELECT @var93 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var93 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var93 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-10-27T08:57:37.9171230+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var94 sysname;
    SELECT @var94 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var94 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var94 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-10-27T08:57:37.9164209+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var95 sysname;
    SELECT @var95 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var95 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var95 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-10-27T08:57:37.9159163+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var96 sysname;
    SELECT @var96 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var96 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var96 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-10-27T08:57:37.9154287+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var97 sysname;
    SELECT @var97 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var97 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var97 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-10-27T08:57:37.9151722+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var98 sysname;
    SELECT @var98 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var98 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var98 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-10-27T08:57:37.9146819+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var99 sysname;
    SELECT @var99 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var99 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var99 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-10-27T08:57:37.9141245+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var100 sysname;
    SELECT @var100 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var100 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var100 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-10-27T08:57:37.9134665+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    DECLARE @var101 sysname;
    SELECT @var101 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var101 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var101 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-10-27T08:57:37.9131603+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027015738_UpdateRefeshTokenPrimaryKey1')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231027015738_UpdateRefeshTokenPrimaryKey1', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    ALTER TABLE [RefeshToken] DROP CONSTRAINT [PK_RefeshToken];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var102 sysname;
    SELECT @var102 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var102 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var102 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-10-27T09:01:19.3267865+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var103 sysname;
    SELECT @var103 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var103 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var103 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-10-27T09:01:19.3265423+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var104 sysname;
    SELECT @var104 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var104 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var104 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-10-27T09:01:19.3252545+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var105 sysname;
    SELECT @var105 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var105 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var105 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-10-27T09:01:19.3250725+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var106 sysname;
    SELECT @var106 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'Id');
    IF @var106 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var106 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT N'e5adbbec_1' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var107 sysname;
    SELECT @var107 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var107 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var107 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-10-27T09:01:19.3239053+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var108 sysname;
    SELECT @var108 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var108 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var108 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-10-27T09:01:19.3236787+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var109 sysname;
    SELECT @var109 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var109 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var109 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-10-27T09:01:19.3232559+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var110 sysname;
    SELECT @var110 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var110 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var110 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-10-27T09:01:19.3225549+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var111 sysname;
    SELECT @var111 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var111 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var111 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-10-27T09:01:19.3220646+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var112 sysname;
    SELECT @var112 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var112 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var112 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-10-27T09:01:19.3215582+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var113 sysname;
    SELECT @var113 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var113 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var113 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-10-27T09:01:19.3213028+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var114 sysname;
    SELECT @var114 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var114 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var114 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-10-27T09:01:19.3207918+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var115 sysname;
    SELECT @var115 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var115 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var115 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-10-27T09:01:19.3202321+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var116 sysname;
    SELECT @var116 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var116 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var116 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-10-27T09:01:19.3195510+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    DECLARE @var117 sysname;
    SELECT @var117 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var117 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var117 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-10-27T09:01:19.3192416+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    ALTER TABLE [RefeshToken] ADD CONSTRAINT [PK_RefeshToken] PRIMARY KEY ([Id], [RefeshToken]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020119_UpdateRefeshTokenPrimaryKey2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231027020119_UpdateRefeshTokenPrimaryKey2', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    ALTER TABLE [RefeshToken] DROP CONSTRAINT [FK_RefeshToken_User_UserId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    ALTER TABLE [RefeshToken] DROP CONSTRAINT [PK_RefeshToken];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DROP INDEX [IX_RefeshToken_UserId] ON [RefeshToken];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var118 sysname;
    SELECT @var118 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var118 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var118 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-10-27T09:04:31.0145400+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var119 sysname;
    SELECT @var119 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var119 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var119 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-10-27T09:04:31.0141952+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var120 sysname;
    SELECT @var120 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var120 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var120 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-10-27T09:04:31.0122745+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var121 sysname;
    SELECT @var121 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var121 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var121 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-10-27T09:04:31.0120179+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var122 sysname;
    SELECT @var122 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'Id');
    IF @var122 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var122 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT N'39999f48_2' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var123 sysname;
    SELECT @var123 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var123 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var123 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-10-27T09:04:31.0107076+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var124 sysname;
    SELECT @var124 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var124 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var124 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-10-27T09:04:31.0104180+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var125 sysname;
    SELECT @var125 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var125 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var125 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-10-27T09:04:31.0099010+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var126 sysname;
    SELECT @var126 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var126 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var126 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-10-27T09:04:31.0089801+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var127 sysname;
    SELECT @var127 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var127 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var127 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-10-27T09:04:31.0083692+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var128 sysname;
    SELECT @var128 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var128 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var128 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-10-27T09:04:31.0077697+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var129 sysname;
    SELECT @var129 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var129 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var129 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-10-27T09:04:31.0074166+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var130 sysname;
    SELECT @var130 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var130 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var130 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-10-27T09:04:31.0067922+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var131 sysname;
    SELECT @var131 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var131 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var131 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-10-27T09:04:31.0060952+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var132 sysname;
    SELECT @var132 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var132 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var132 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-10-27T09:04:31.0052702+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    DECLARE @var133 sysname;
    SELECT @var133 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var133 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var133 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-10-27T09:04:31.0048138+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    ALTER TABLE [RefeshToken] ADD CONSTRAINT [PK_RefeshToken] PRIMARY KEY ([Id], [RefeshToken], [UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    CREATE INDEX [IX_RefeshToken_UserId] ON [RefeshToken] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    ALTER TABLE [RefeshToken] ADD CONSTRAINT [FK_RefeshToken_User] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231027020431_UpdateRefeshTokenPrimaryKey3')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231027020431_UpdateRefeshTokenPrimaryKey3', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var134 sysname;
    SELECT @var134 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var134 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var134 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-11-03T15:26:29.8663581+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var135 sysname;
    SELECT @var135 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var135 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var135 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-11-03T15:26:29.8660962+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var136 sysname;
    SELECT @var136 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var136 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var136 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-11-03T15:26:29.8646427+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var137 sysname;
    SELECT @var137 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var137 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var137 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-11-03T15:26:29.8643803+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var138 sysname;
    SELECT @var138 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'Id');
    IF @var138 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var138 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT N'c0dbf92b_b' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var139 sysname;
    SELECT @var139 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var139 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var139 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-11-03T15:26:29.8633520+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var140 sysname;
    SELECT @var140 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var140 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var140 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-11-03T15:26:29.8630889+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var141 sysname;
    SELECT @var141 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var141 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var141 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-11-03T15:26:29.8626202+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var142 sysname;
    SELECT @var142 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var142 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var142 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-11-03T15:26:29.8618479+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var143 sysname;
    SELECT @var143 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var143 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var143 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-11-03T15:26:29.8613142+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var144 sysname;
    SELECT @var144 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var144 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var144 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-11-03T15:26:29.8607756+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var145 sysname;
    SELECT @var145 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var145 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var145 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-11-03T15:26:29.8604848+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var146 sysname;
    SELECT @var146 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var146 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var146 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-11-03T15:26:29.8599329+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var147 sysname;
    SELECT @var147 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var147 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var147 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-11-03T15:26:29.8592958+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var148 sysname;
    SELECT @var148 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var148 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var148 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-11-03T15:26:29.8585376+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    DECLARE @var149 sysname;
    SELECT @var149 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var149 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var149 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-11-03T15:26:29.8580428+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    CREATE TABLE [RecoveryToken] (
        [Id] nvarchar(50) NOT NULL DEFAULT N'db3b1a8d_1',
        [UserId] nvarchar(50) NOT NULL,
        [PinCode] nvarchar(7) NOT NULL,
        [Expires] datetime2 NOT NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedTime] datetime2 NOT NULL DEFAULT '2023-11-03T15:26:29.8669947+07:00',
        [CreatedBy] nvarchar(max) NOT NULL DEFAULT N'admin',
        CONSTRAINT [PK_RecoveryToken] PRIMARY KEY ([Id], [UserId]),
        CONSTRAINT [FK_Recovery_User] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    CREATE INDEX [IX_RecoveryToken_UserId] ON [RecoveryToken] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231103082630_AddTableRecovery')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231103082630_AddTableRecovery', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var150 sysname;
    SELECT @var150 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var150 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var150 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-11-07T13:15:26.5441352+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var151 sysname;
    SELECT @var151 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var151 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var151 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-11-07T13:15:26.5438781+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var152 sysname;
    SELECT @var152 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var152 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var152 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-11-07T13:15:26.5423352+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var153 sysname;
    SELECT @var153 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var153 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var153 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-11-07T13:15:26.5420518+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var154 sysname;
    SELECT @var154 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'Id');
    IF @var154 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var154 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT N'29a8aed6_d' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var155 sysname;
    SELECT @var155 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RecoveryToken]') AND [c].[name] = N'CreatedTime');
    IF @var155 IS NOT NULL EXEC(N'ALTER TABLE [RecoveryToken] DROP CONSTRAINT [' + @var155 + '];');
    ALTER TABLE [RecoveryToken] ADD DEFAULT '2023-11-07T13:15:26.5448164+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var156 sysname;
    SELECT @var156 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RecoveryToken]') AND [c].[name] = N'Id');
    IF @var156 IS NOT NULL EXEC(N'ALTER TABLE [RecoveryToken] DROP CONSTRAINT [' + @var156 + '];');
    ALTER TABLE [RecoveryToken] ADD DEFAULT N'5fd2c1d7_6' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var157 sysname;
    SELECT @var157 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var157 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var157 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-11-07T13:15:26.5410319+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var158 sysname;
    SELECT @var158 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var158 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var158 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-11-07T13:15:26.5407876+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var159 sysname;
    SELECT @var159 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var159 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var159 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-11-07T13:15:26.5403193+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var160 sysname;
    SELECT @var160 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var160 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var160 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-11-07T13:15:26.5395431+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var161 sysname;
    SELECT @var161 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var161 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var161 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-11-07T13:15:26.5390155+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var162 sysname;
    SELECT @var162 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var162 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var162 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-11-07T13:15:26.5384868+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var163 sysname;
    SELECT @var163 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var163 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var163 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-11-07T13:15:26.5381771+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var164 sysname;
    SELECT @var164 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var164 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var164 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-11-07T13:15:26.5376254+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var165 sysname;
    SELECT @var165 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var165 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var165 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-11-07T13:15:26.5368806+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var166 sysname;
    SELECT @var166 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var166 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var166 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-11-07T13:15:26.5361219+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    ALTER TABLE [Cart] ADD [PhoneNumber] nvarchar(50) NOT NULL DEFAULT N'';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    DECLARE @var167 sysname;
    SELECT @var167 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var167 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var167 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-11-07T13:15:26.5357746+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231107061526_AddColumnPhoneNumber_Cart')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231107061526_AddColumnPhoneNumber_Cart', N'7.0.12');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var168 sysname;
    SELECT @var168 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Ward]') AND [c].[name] = N'CreatedTime');
    IF @var168 IS NOT NULL EXEC(N'ALTER TABLE [Ward] DROP CONSTRAINT [' + @var168 + '];');
    ALTER TABLE [Ward] ADD DEFAULT '2023-11-10T11:13:08.2048373+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var169 sysname;
    SELECT @var169 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'CreatedTime');
    IF @var169 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var169 + '];');
    ALTER TABLE [User] ADD DEFAULT '2023-11-10T11:13:08.2045971+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var170 sysname;
    SELECT @var170 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Store]') AND [c].[name] = N'CreatedTime');
    IF @var170 IS NOT NULL EXEC(N'ALTER TABLE [Store] DROP CONSTRAINT [' + @var170 + '];');
    ALTER TABLE [Store] ADD DEFAULT '2023-11-10T11:13:08.2030565+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var171 sysname;
    SELECT @var171 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'CreatedTime');
    IF @var171 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var171 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT '2023-11-10T11:13:08.2028254+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var172 sysname;
    SELECT @var172 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RefeshToken]') AND [c].[name] = N'Id');
    IF @var172 IS NOT NULL EXEC(N'ALTER TABLE [RefeshToken] DROP CONSTRAINT [' + @var172 + '];');
    ALTER TABLE [RefeshToken] ADD DEFAULT N'6da89c6f_7' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var173 sysname;
    SELECT @var173 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RecoveryToken]') AND [c].[name] = N'CreatedTime');
    IF @var173 IS NOT NULL EXEC(N'ALTER TABLE [RecoveryToken] DROP CONSTRAINT [' + @var173 + '];');
    ALTER TABLE [RecoveryToken] ADD DEFAULT '2023-11-10T11:13:08.2054621+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var174 sysname;
    SELECT @var174 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RecoveryToken]') AND [c].[name] = N'Id');
    IF @var174 IS NOT NULL EXEC(N'ALTER TABLE [RecoveryToken] DROP CONSTRAINT [' + @var174 + '];');
    ALTER TABLE [RecoveryToken] ADD DEFAULT N'0449fbc5_3' FOR [Id];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var175 sysname;
    SELECT @var175 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'CreatedTime');
    IF @var175 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var175 + '];');
    ALTER TABLE [Product] ADD DEFAULT '2023-11-10T11:13:08.2018739+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var176 sysname;
    SELECT @var176 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'PhoneNumber');
    IF @var176 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var176 + '];');
    ALTER TABLE [Information] ALTER COLUMN [PhoneNumber] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var177 sysname;
    SELECT @var177 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Information]') AND [c].[name] = N'CreatedTime');
    IF @var177 IS NOT NULL EXEC(N'ALTER TABLE [Information] DROP CONSTRAINT [' + @var177 + '];');
    ALTER TABLE [Information] ADD DEFAULT '2023-11-10T11:13:08.2016422+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var178 sysname;
    SELECT @var178 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[District]') AND [c].[name] = N'CreatedTime');
    IF @var178 IS NOT NULL EXEC(N'ALTER TABLE [District] DROP CONSTRAINT [' + @var178 + '];');
    ALTER TABLE [District] ADD DEFAULT '2023-11-10T11:13:08.2011941+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var179 sysname;
    SELECT @var179 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DetailsCart]') AND [c].[name] = N'CreatedTime');
    IF @var179 IS NOT NULL EXEC(N'ALTER TABLE [DetailsCart] DROP CONSTRAINT [' + @var179 + '];');
    ALTER TABLE [DetailsCart] ADD DEFAULT '2023-11-10T11:13:08.2004889+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var180 sysname;
    SELECT @var180 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var180 IS NOT NULL EXEC(N'ALTER TABLE [ConsumpType] DROP CONSTRAINT [' + @var180 + '];');
    ALTER TABLE [ConsumpType] ADD DEFAULT '2023-11-10T11:13:08.2000021+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var181 sysname;
    SELECT @var181 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Collection]') AND [c].[name] = N'CreatedTime');
    IF @var181 IS NOT NULL EXEC(N'ALTER TABLE [Collection] DROP CONSTRAINT [' + @var181 + '];');
    ALTER TABLE [Collection] ADD DEFAULT '2023-11-10T11:13:08.1995182+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var182 sysname;
    SELECT @var182 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[City]') AND [c].[name] = N'CreatedTime');
    IF @var182 IS NOT NULL EXEC(N'ALTER TABLE [City] DROP CONSTRAINT [' + @var182 + '];');
    ALTER TABLE [City] ADD DEFAULT '2023-11-10T11:13:08.1992511+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var183 sysname;
    SELECT @var183 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryProduct]') AND [c].[name] = N'CreatedTime');
    IF @var183 IS NOT NULL EXEC(N'ALTER TABLE [CategoryProduct] DROP CONSTRAINT [' + @var183 + '];');
    ALTER TABLE [CategoryProduct] ADD DEFAULT '2023-11-10T11:13:08.1987397+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var184 sysname;
    SELECT @var184 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CategoryConsumpType]') AND [c].[name] = N'CreatedTime');
    IF @var184 IS NOT NULL EXEC(N'ALTER TABLE [CategoryConsumpType] DROP CONSTRAINT [' + @var184 + '];');
    ALTER TABLE [CategoryConsumpType] ADD DEFAULT '2023-11-10T11:13:08.1981521+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var185 sysname;
    SELECT @var185 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Cart]') AND [c].[name] = N'CreatedTime');
    IF @var185 IS NOT NULL EXEC(N'ALTER TABLE [Cart] DROP CONSTRAINT [' + @var185 + '];');
    ALTER TABLE [Cart] ADD DEFAULT '2023-11-10T11:13:08.1974563+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    DECLARE @var186 sysname;
    SELECT @var186 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[BranchStore]') AND [c].[name] = N'CreatedTime');
    IF @var186 IS NOT NULL EXEC(N'ALTER TABLE [BranchStore] DROP CONSTRAINT [' + @var186 + '];');
    ALTER TABLE [BranchStore] ADD DEFAULT '2023-11-10T11:13:08.1971427+07:00' FOR [CreatedTime];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231110041308_updatetableInformation1')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231110041308_updatetableInformation1', N'7.0.12');
END;
GO

COMMIT;
GO


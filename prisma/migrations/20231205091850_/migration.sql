/*
  Warnings:

  - You are about to drop the column `userId` on the `UserPreference` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[title]` on the table `Role` will be added. If there are existing duplicate values, this will fail.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "isAdmin" BOOLEAN NOT NULL,
    "userPrefernceId" TEXT,
    "roleId" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "User_userPrefernceId_fkey" FOREIGN KEY ("userPrefernceId") REFERENCES "UserPreference" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_User" ("age", "createdAt", "email", "id", "isAdmin", "name", "roleId", "updatedAt") SELECT "age", "createdAt", "email", "id", "isAdmin", "name", "roleId", "updatedAt" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
CREATE UNIQUE INDEX "User_userPrefernceId_key" ON "User"("userPrefernceId");
CREATE UNIQUE INDEX "User_name_age_key" ON "User"("name", "age");
CREATE TABLE "new_UserPreference" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "emailUpdates" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_UserPreference" ("createdAt", "emailUpdates", "id", "updatedAt") SELECT "createdAt", "emailUpdates", "id", "updatedAt" FROM "UserPreference";
DROP TABLE "UserPreference";
ALTER TABLE "new_UserPreference" RENAME TO "UserPreference";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "Role_title_key" ON "Role"("title");

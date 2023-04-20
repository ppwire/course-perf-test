/*
  Warnings:

  - The primary key for the `CourseMasterRecord` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `revision` on the `CourseMasterRecord` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "CourseMasterRecordRelation" DROP CONSTRAINT "CourseMasterRecordRelation_masterRecordId_masterRecordRevi_fkey";

-- AlterTable
ALTER TABLE "CourseMasterRecord" DROP CONSTRAINT "CourseMasterRecord_pkey",
DROP COLUMN "revision",
ADD CONSTRAINT "CourseMasterRecord_pkey" PRIMARY KEY ("masterRecordId", "masterRecordRevision");

-- AddForeignKey
ALTER TABLE "CourseMasterRecordRelation" ADD CONSTRAINT "CourseMasterRecordRelation_masterRecordId_masterRecordRevi_fkey" FOREIGN KEY ("masterRecordId", "masterRecordRevision") REFERENCES "CourseMasterRecord"("masterRecordId", "masterRecordRevision") ON DELETE RESTRICT ON UPDATE CASCADE;

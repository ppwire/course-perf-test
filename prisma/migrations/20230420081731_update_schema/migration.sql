/*
  Warnings:

  - The primary key for the `CourseMasterRecord` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `masterRecordRevision` on the `CourseMasterRecordRelation` table. All the data in the column will be lost.
  - Added the required column `id` to the `CourseMasterRecord` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "CourseMasterRecordRelation" DROP CONSTRAINT "CourseMasterRecordRelation_masterRecordId_masterRecordRevi_fkey";

-- AlterTable
ALTER TABLE "CourseMasterRecord" DROP CONSTRAINT "CourseMasterRecord_pkey",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "CourseMasterRecord_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "CourseMasterRecordRelation" DROP COLUMN "masterRecordRevision";

-- AddForeignKey
ALTER TABLE "CourseMasterRecordRelation" ADD CONSTRAINT "CourseMasterRecordRelation_masterRecordId_fkey" FOREIGN KEY ("masterRecordId") REFERENCES "CourseMasterRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

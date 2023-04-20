/*
  Warnings:

  - The primary key for the `CourseMasterRecordRelation` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `metaRevision` on the `CourseMasterRecordRelation` table. All the data in the column will be lost.
  - You are about to drop the column `revision` on the `CourseMasterRecordRelation` table. All the data in the column will be lost.
  - Added the required column `courseMetaRevision` to the `CourseMasterRecordRelation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `courseRevision` to the `CourseMasterRecordRelation` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "CourseMasterRecordRelation" DROP CONSTRAINT "CourseMasterRecordRelation_courseId_metaRevision_revision_fkey";

-- AlterTable
ALTER TABLE "CourseMasterRecordRelation" DROP CONSTRAINT "CourseMasterRecordRelation_pkey",
DROP COLUMN "metaRevision",
DROP COLUMN "revision",
ADD COLUMN     "courseMetaRevision" INTEGER NOT NULL,
ADD COLUMN     "courseRevision" INTEGER NOT NULL,
ADD CONSTRAINT "CourseMasterRecordRelation_pkey" PRIMARY KEY ("masterRecordId", "courseId", "courseMetaRevision");

-- AddForeignKey
ALTER TABLE "CourseMasterRecordRelation" ADD CONSTRAINT "CourseMasterRecordRelation_courseId_courseMetaRevision_cou_fkey" FOREIGN KEY ("courseId", "courseMetaRevision", "courseRevision") REFERENCES "CourseRevision"("courseId", "metaRevision", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

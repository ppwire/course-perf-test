/*
  Warnings:

  - The primary key for the `CourseAsset` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `displayName` on the `CourseAsset` table. All the data in the column will be lost.
  - You are about to drop the column `other` on the `CourseAsset` table. All the data in the column will be lost.
  - You are about to drop the column `revision` on the `CourseAsset` table. All the data in the column will be lost.
  - You are about to drop the column `timestamp` on the `CourseAsset` table. All the data in the column will be lost.
  - The primary key for the `CoursePartRelation` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `brickRevision` on the `CoursePartRelation` table. All the data in the column will be lost.
  - You are about to drop the column `partMetaRevision` on the `CoursePartRelation` table. All the data in the column will be lost.
  - You are about to drop the column `revision` on the `CoursePartRelation` table. All the data in the column will be lost.
  - The primary key for the `PartSectionRelation` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `partMetaRevision` on the `PartSectionRelation` table. All the data in the column will be lost.
  - You are about to drop the column `sectionMetaRevision` on the `PartSectionRelation` table. All the data in the column will be lost.
  - The primary key for the `SectionSubsectionRelation` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `sectionMetaRevision` on the `SectionSubsectionRelation` table. All the data in the column will be lost.
  - You are about to drop the column `subsectionMetaRevision` on the `SectionSubsectionRelation` table. All the data in the column will be lost.
  - The primary key for the `SubsectionCourseAssetRelation` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `assetId` on the `SubsectionCourseAssetRelation` table. All the data in the column will be lost.
  - You are about to drop the column `assetRevision` on the `SubsectionCourseAssetRelation` table. All the data in the column will be lost.
  - You are about to drop the column `subsectionMetaRevision` on the `SubsectionCourseAssetRelation` table. All the data in the column will be lost.
  - You are about to drop the `CourseVersioned` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PartVersioned` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SectionVersioned` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SubsectionVersioned` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `id` to the `CourseAsset` table without a default value. This is not possible if the table is not empty.
  - Added the required column `courseItemsRevision` to the `CoursePartRelation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `courseRevision` to the `CoursePartRelation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `partItemsRevision` to the `PartSectionRelation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sectionItemsRevision` to the `SectionSubsectionRelation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `courseAssetId` to the `SubsectionCourseAssetRelation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `courseAssetRevision` to the `SubsectionCourseAssetRelation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subsectionItemsRevision` to the `SubsectionCourseAssetRelation` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "CourseMasterRecordRelation" DROP CONSTRAINT "CourseMasterRecordRelation_courseId_metaRevision_revision_fkey";

-- DropForeignKey
ALTER TABLE "CoursePartRelation" DROP CONSTRAINT "CoursePartRelation_courseId_brickRevision_revision_fkey";

-- DropForeignKey
ALTER TABLE "CoursePartRelation" DROP CONSTRAINT "CoursePartRelation_partId_partRevision_partMetaRevision_fkey";

-- DropForeignKey
ALTER TABLE "CourseVersioned" DROP CONSTRAINT "CourseVersioned_courseId_fkey";

-- DropForeignKey
ALTER TABLE "PartSectionRelation" DROP CONSTRAINT "PartSectionRelation_partId_partRevision_partMetaRevision_fkey";

-- DropForeignKey
ALTER TABLE "PartSectionRelation" DROP CONSTRAINT "PartSectionRelation_sectionId_sectionRevision_sectionMetaR_fkey";

-- DropForeignKey
ALTER TABLE "PartVersioned" DROP CONSTRAINT "PartVersioned_partId_fkey";

-- DropForeignKey
ALTER TABLE "SectionSubsectionRelation" DROP CONSTRAINT "SectionSubsectionRelation_sectionId_sectionRevision_sectio_fkey";

-- DropForeignKey
ALTER TABLE "SectionSubsectionRelation" DROP CONSTRAINT "SectionSubsectionRelation_subsectionId_subsectionRevision__fkey";

-- DropForeignKey
ALTER TABLE "SectionVersioned" DROP CONSTRAINT "SectionVersioned_sectionId_fkey";

-- DropForeignKey
ALTER TABLE "SubsectionCourseAssetRelation" DROP CONSTRAINT "SubsectionCourseAssetRelation_assetId_assetRevision_fkey";

-- DropForeignKey
ALTER TABLE "SubsectionCourseAssetRelation" DROP CONSTRAINT "SubsectionCourseAssetRelation_subsectionId_subsectionRevis_fkey";

-- DropForeignKey
ALTER TABLE "SubsectionVersioned" DROP CONSTRAINT "SubsectionVersioned_subsectionId_fkey";

-- AlterTable
ALTER TABLE "CourseAsset" DROP CONSTRAINT "CourseAsset_pkey",
DROP COLUMN "displayName",
DROP COLUMN "other",
DROP COLUMN "revision",
DROP COLUMN "timestamp",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "CourseAsset_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "CoursePartRelation" DROP CONSTRAINT "CoursePartRelation_pkey",
DROP COLUMN "brickRevision",
DROP COLUMN "partMetaRevision",
DROP COLUMN "revision",
ADD COLUMN     "courseItemsRevision" INTEGER NOT NULL,
ADD COLUMN     "courseRevision" INTEGER NOT NULL,
ADD CONSTRAINT "CoursePartRelation_pkey" PRIMARY KEY ("courseId", "partId", "courseItemsRevision");

-- AlterTable
ALTER TABLE "PartSectionRelation" DROP CONSTRAINT "PartSectionRelation_pkey",
DROP COLUMN "partMetaRevision",
DROP COLUMN "sectionMetaRevision",
ADD COLUMN     "partItemsRevision" INTEGER NOT NULL,
ADD CONSTRAINT "PartSectionRelation_pkey" PRIMARY KEY ("partId", "sectionId", "partItemsRevision");

-- AlterTable
ALTER TABLE "SectionSubsectionRelation" DROP CONSTRAINT "SectionSubsectionRelation_pkey",
DROP COLUMN "sectionMetaRevision",
DROP COLUMN "subsectionMetaRevision",
ADD COLUMN     "sectionItemsRevision" INTEGER NOT NULL,
ADD CONSTRAINT "SectionSubsectionRelation_pkey" PRIMARY KEY ("sectionId", "subsectionId", "sectionItemsRevision");

-- AlterTable
ALTER TABLE "SubsectionCourseAssetRelation" DROP CONSTRAINT "SubsectionCourseAssetRelation_pkey",
DROP COLUMN "assetId",
DROP COLUMN "assetRevision",
DROP COLUMN "subsectionMetaRevision",
ADD COLUMN     "courseAssetId" TEXT NOT NULL,
ADD COLUMN     "courseAssetRevision" INTEGER NOT NULL,
ADD COLUMN     "subsectionItemsRevision" INTEGER NOT NULL,
ADD CONSTRAINT "SubsectionCourseAssetRelation_pkey" PRIMARY KEY ("subsectionId", "courseAssetId", "subsectionItemsRevision");

-- DropTable
DROP TABLE "CourseVersioned";

-- DropTable
DROP TABLE "PartVersioned";

-- DropTable
DROP TABLE "SectionVersioned";

-- DropTable
DROP TABLE "SubsectionVersioned";

-- CreateTable
CREATE TABLE "CourseRevision" (
    "courseId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "internalNote" TEXT NOT NULL,
    "itemsRevision" INTEGER NOT NULL,
    "metaRevision" INTEGER NOT NULL,

    CONSTRAINT "CourseRevision_pkey" PRIMARY KEY ("courseId","revision")
);

-- CreateTable
CREATE TABLE "PartRevision" (
    "partId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "itemsRevision" INTEGER NOT NULL,

    CONSTRAINT "PartRevision_pkey" PRIMARY KEY ("partId","revision")
);

-- CreateTable
CREATE TABLE "SectionRevision" (
    "sectionId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "itemsRevision" INTEGER NOT NULL,

    CONSTRAINT "SectionRevision_pkey" PRIMARY KEY ("sectionId","revision")
);

-- CreateTable
CREATE TABLE "SubsectionRevision" (
    "subsectionId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "itemsRevision" INTEGER NOT NULL,

    CONSTRAINT "SubsectionRevision_pkey" PRIMARY KEY ("subsectionId","revision")
);

-- CreateTable
CREATE TABLE "CourseAssetRevision" (
    "courseAssetId" TEXT NOT NULL,
    "timestamp" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "other" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,

    CONSTRAINT "CourseAssetRevision_pkey" PRIMARY KEY ("courseAssetId","revision")
);

-- CreateIndex
CREATE UNIQUE INDEX "CourseRevision_courseId_revision_metaRevision_key" ON "CourseRevision"("courseId", "revision", "metaRevision");

-- CreateIndex
CREATE UNIQUE INDEX "CourseRevision_courseId_revision_itemsRevision_key" ON "CourseRevision"("courseId", "revision", "itemsRevision");

-- CreateIndex
CREATE UNIQUE INDEX "PartRevision_partId_revision_itemsRevision_key" ON "PartRevision"("partId", "revision", "itemsRevision");

-- CreateIndex
CREATE UNIQUE INDEX "SectionRevision_sectionId_revision_itemsRevision_key" ON "SectionRevision"("sectionId", "revision", "itemsRevision");

-- CreateIndex
CREATE UNIQUE INDEX "SubsectionRevision_subsectionId_revision_itemsRevision_key" ON "SubsectionRevision"("subsectionId", "revision", "itemsRevision");

-- AddForeignKey
ALTER TABLE "CourseRevision" ADD CONSTRAINT "CourseRevision_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartRevision" ADD CONSTRAINT "PartRevision_partId_fkey" FOREIGN KEY ("partId") REFERENCES "Part"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SectionRevision" ADD CONSTRAINT "SectionRevision_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "Section"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubsectionRevision" ADD CONSTRAINT "SubsectionRevision_subsectionId_fkey" FOREIGN KEY ("subsectionId") REFERENCES "Subsection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseAssetRevision" ADD CONSTRAINT "CourseAssetRevision_courseAssetId_fkey" FOREIGN KEY ("courseAssetId") REFERENCES "CourseAsset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseMasterRecordRelation" ADD CONSTRAINT "CourseMasterRecordRelation_courseId_metaRevision_revision_fkey" FOREIGN KEY ("courseId", "metaRevision", "revision") REFERENCES "CourseRevision"("courseId", "metaRevision", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoursePartRelation" ADD CONSTRAINT "CoursePartRelation_courseId_courseItemsRevision_courseRevi_fkey" FOREIGN KEY ("courseId", "courseItemsRevision", "courseRevision") REFERENCES "CourseRevision"("courseId", "itemsRevision", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoursePartRelation" ADD CONSTRAINT "CoursePartRelation_partId_partRevision_fkey" FOREIGN KEY ("partId", "partRevision") REFERENCES "PartRevision"("partId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartSectionRelation" ADD CONSTRAINT "PartSectionRelation_partId_partItemsRevision_partRevision_fkey" FOREIGN KEY ("partId", "partItemsRevision", "partRevision") REFERENCES "PartRevision"("partId", "itemsRevision", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartSectionRelation" ADD CONSTRAINT "PartSectionRelation_sectionId_sectionRevision_fkey" FOREIGN KEY ("sectionId", "sectionRevision") REFERENCES "SectionRevision"("sectionId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SectionSubsectionRelation" ADD CONSTRAINT "SectionSubsectionRelation_sectionId_sectionItemsRevision_s_fkey" FOREIGN KEY ("sectionId", "sectionItemsRevision", "sectionRevision") REFERENCES "SectionRevision"("sectionId", "itemsRevision", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SectionSubsectionRelation" ADD CONSTRAINT "SectionSubsectionRelation_subsectionId_subsectionRevision_fkey" FOREIGN KEY ("subsectionId", "subsectionRevision") REFERENCES "SubsectionRevision"("subsectionId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubsectionCourseAssetRelation" ADD CONSTRAINT "SubsectionCourseAssetRelation_subsectionId_subsectionItems_fkey" FOREIGN KEY ("subsectionId", "subsectionItemsRevision", "subsectionRevision") REFERENCES "SubsectionRevision"("subsectionId", "itemsRevision", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubsectionCourseAssetRelation" ADD CONSTRAINT "SubsectionCourseAssetRelation_courseAssetId_courseAssetRev_fkey" FOREIGN KEY ("courseAssetId", "courseAssetRevision") REFERENCES "CourseAssetRevision"("courseAssetId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

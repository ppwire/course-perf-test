-- CreateTable
CREATE TABLE "Course" (
    "id" TEXT NOT NULL,
    "version" TEXT NOT NULL,

    CONSTRAINT "Course_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CourseVersioned" (
    "courseId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "internalNote" TEXT NOT NULL,
    "brickRevision" INTEGER NOT NULL,
    "metaRevision" INTEGER NOT NULL,

    CONSTRAINT "CourseVersioned_pkey" PRIMARY KEY ("courseId","revision","brickRevision","metaRevision")
);

-- CreateTable
CREATE TABLE "Part" (
    "id" TEXT NOT NULL,

    CONSTRAINT "Part_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PartVersioned" (
    "partId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "metaRevision" INTEGER NOT NULL,

    CONSTRAINT "PartVersioned_pkey" PRIMARY KEY ("partId","revision","metaRevision")
);

-- CreateTable
CREATE TABLE "CoursePartRelation" (
    "courseId" TEXT NOT NULL,
    "partId" TEXT NOT NULL,
    "partMetaRevision" INTEGER NOT NULL,
    "partRevision" INTEGER NOT NULL,
    "brickRevision" INTEGER NOT NULL,
    "revision" INTEGER NOT NULL,

    CONSTRAINT "CoursePartRelation_pkey" PRIMARY KEY ("courseId","partId","brickRevision")
);

-- CreateTable
CREATE TABLE "Section" (
    "id" TEXT NOT NULL,

    CONSTRAINT "Section_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SectionVersioned" (
    "sectionId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "metaRevision" INTEGER NOT NULL,

    CONSTRAINT "SectionVersioned_pkey" PRIMARY KEY ("sectionId","revision","metaRevision")
);

-- CreateTable
CREATE TABLE "PartSectionRelation" (
    "partId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,
    "sectionMetaRevision" INTEGER NOT NULL,
    "partRevision" INTEGER NOT NULL,
    "partMetaRevision" INTEGER NOT NULL,
    "sectionRevision" INTEGER NOT NULL,

    CONSTRAINT "PartSectionRelation_pkey" PRIMARY KEY ("partId","sectionId","partRevision")
);

-- CreateTable
CREATE TABLE "Subsection" (
    "id" TEXT NOT NULL,

    CONSTRAINT "Subsection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubsectionVersioned" (
    "subsectionId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "metaRevision" INTEGER NOT NULL,

    CONSTRAINT "SubsectionVersioned_pkey" PRIMARY KEY ("subsectionId","revision","metaRevision")
);

-- CreateTable
CREATE TABLE "SectionSubsectionRelation" (
    "sectionId" TEXT NOT NULL,
    "subsectionId" TEXT NOT NULL,
    "sectionRevision" INTEGER NOT NULL,
    "subsectionRevision" INTEGER NOT NULL,
    "sectionMetaRevision" INTEGER NOT NULL,
    "subsectionMetaRevision" INTEGER NOT NULL,

    CONSTRAINT "SectionSubsectionRelation_pkey" PRIMARY KEY ("sectionId","subsectionId","sectionRevision")
);

-- CreateTable
CREATE TABLE "SubsectionCourseAssetRelation" (
    "subsectionId" TEXT NOT NULL,
    "assetId" TEXT NOT NULL,
    "assetRevision" INTEGER NOT NULL,
    "subsectionRevision" INTEGER NOT NULL,
    "subsectionMetaRevision" INTEGER NOT NULL,

    CONSTRAINT "SubsectionCourseAssetRelation_pkey" PRIMARY KEY ("subsectionId","assetId","subsectionRevision")
);

-- CreateTable
CREATE TABLE "CourseAsset" (
    "assetId" TEXT NOT NULL,
    "assetRevision" INTEGER NOT NULL,
    "assetType" TEXT NOT NULL,
    "timestamp" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "other" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,

    CONSTRAINT "CourseAsset_pkey" PRIMARY KEY ("assetId","revision")
);

-- CreateTable
CREATE TABLE "CourseBin" (
    "id" TEXT NOT NULL,
    "assets" JSONB[],
    "courseId" TEXT NOT NULL,

    CONSTRAINT "CourseBin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CourseMasterRecord" (
    "masterRecordId" TEXT NOT NULL,
    "masterRecordRevision" INTEGER NOT NULL,
    "revision" INTEGER NOT NULL,
    "values" JSONB[],

    CONSTRAINT "CourseMasterRecord_pkey" PRIMARY KEY ("masterRecordId","revision")
);

-- CreateTable
CREATE TABLE "CourseMasterRecordRelation" (
    "masterRecordId" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,
    "masterRecordRevision" INTEGER NOT NULL,
    "metaRevision" INTEGER NOT NULL,
    "revision" INTEGER NOT NULL,

    CONSTRAINT "CourseMasterRecordRelation_pkey" PRIMARY KEY ("masterRecordId","courseId","metaRevision")
);

-- CreateIndex
CREATE UNIQUE INDEX "CourseVersioned_courseId_brickRevision_revision_key" ON "CourseVersioned"("courseId", "brickRevision", "revision");

-- CreateIndex
CREATE UNIQUE INDEX "CourseVersioned_courseId_metaRevision_revision_key" ON "CourseVersioned"("courseId", "metaRevision", "revision");

-- AddForeignKey
ALTER TABLE "CourseVersioned" ADD CONSTRAINT "CourseVersioned_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartVersioned" ADD CONSTRAINT "PartVersioned_partId_fkey" FOREIGN KEY ("partId") REFERENCES "Part"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoursePartRelation" ADD CONSTRAINT "CoursePartRelation_courseId_brickRevision_revision_fkey" FOREIGN KEY ("courseId", "brickRevision", "revision") REFERENCES "CourseVersioned"("courseId", "brickRevision", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoursePartRelation" ADD CONSTRAINT "CoursePartRelation_partId_partRevision_partMetaRevision_fkey" FOREIGN KEY ("partId", "partRevision", "partMetaRevision") REFERENCES "PartVersioned"("partId", "revision", "metaRevision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SectionVersioned" ADD CONSTRAINT "SectionVersioned_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "Section"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartSectionRelation" ADD CONSTRAINT "PartSectionRelation_partId_partRevision_partMetaRevision_fkey" FOREIGN KEY ("partId", "partRevision", "partMetaRevision") REFERENCES "PartVersioned"("partId", "revision", "metaRevision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartSectionRelation" ADD CONSTRAINT "PartSectionRelation_sectionId_sectionRevision_sectionMetaR_fkey" FOREIGN KEY ("sectionId", "sectionRevision", "sectionMetaRevision") REFERENCES "SectionVersioned"("sectionId", "revision", "metaRevision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubsectionVersioned" ADD CONSTRAINT "SubsectionVersioned_subsectionId_fkey" FOREIGN KEY ("subsectionId") REFERENCES "Subsection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SectionSubsectionRelation" ADD CONSTRAINT "SectionSubsectionRelation_sectionId_sectionRevision_sectio_fkey" FOREIGN KEY ("sectionId", "sectionRevision", "sectionMetaRevision") REFERENCES "SectionVersioned"("sectionId", "revision", "metaRevision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SectionSubsectionRelation" ADD CONSTRAINT "SectionSubsectionRelation_subsectionId_subsectionRevision__fkey" FOREIGN KEY ("subsectionId", "subsectionRevision", "subsectionMetaRevision") REFERENCES "SubsectionVersioned"("subsectionId", "revision", "metaRevision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubsectionCourseAssetRelation" ADD CONSTRAINT "SubsectionCourseAssetRelation_subsectionId_subsectionRevis_fkey" FOREIGN KEY ("subsectionId", "subsectionRevision", "subsectionMetaRevision") REFERENCES "SubsectionVersioned"("subsectionId", "revision", "metaRevision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubsectionCourseAssetRelation" ADD CONSTRAINT "SubsectionCourseAssetRelation_assetId_assetRevision_fkey" FOREIGN KEY ("assetId", "assetRevision") REFERENCES "CourseAsset"("assetId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseBin" ADD CONSTRAINT "CourseBin_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseMasterRecordRelation" ADD CONSTRAINT "CourseMasterRecordRelation_masterRecordId_masterRecordRevi_fkey" FOREIGN KEY ("masterRecordId", "masterRecordRevision") REFERENCES "CourseMasterRecord"("masterRecordId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseMasterRecordRelation" ADD CONSTRAINT "CourseMasterRecordRelation_courseId_metaRevision_revision_fkey" FOREIGN KEY ("courseId", "metaRevision", "revision") REFERENCES "CourseVersioned"("courseId", "metaRevision", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

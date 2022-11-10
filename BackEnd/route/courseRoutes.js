const router = require("express").Router();
const authMiddleware = require("../service/tokenValidationService");
const CourseController = require("../controller/courseController");
const courseController = new CourseController();

router.use(authMiddleware);
router.route("/create").post(courseController.create);
router.route("/my_list").get(courseController.getMyList);
router.route("/my_list_admin").get(courseController.getMyListAdmin);
router.route("/class_options").post(courseController.getClassOptions);
router.route("/subject_options").post(courseController.getSubjectOptions);
router.route("/batch_options").post(courseController.getBatchOptions);
router.route("/batches").post(courseController.getBatches);
router.route("/add_batch").post(courseController.addBatch);
router.route("/enroll").post(courseController.enroll);
router.route("/enroll/approve").post(courseController.approveEnrollment);
router.route("/enroll/decline").post(courseController.declineEnrollment);
router.route("/enroll/cancel").post(courseController.cancelEnrollment);

module.exports = router;

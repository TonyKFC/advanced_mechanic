INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES ('mechanic', 'Mechanic', 1);

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (26, 'mechanic', 0, 'recrue', 'Recruit', 12, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (27, 'mechanic', 1, 'novice', 'Novice', 24, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (28, 'mechanic', 2, 'experimente', 'Experienced', 36, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (29, 'mechanic', 3, 'chief', 'Leader', 48, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (30, 'mechanic', 4, 'boss', 'Boss', 0, '{}', '{}');

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES ('society_mechanic', 'Mechanic', 1);
INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES (4, 'society_mechanic', 0, NULL);

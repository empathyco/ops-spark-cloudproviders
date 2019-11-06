resource "aws_sfn_state_machine" "sfn_state_machine" {
    name = "${var.sfn_name}"
    role_arn = "${var.sfn_role}" 
    definition = file("code/step.json")
}

variable "existing_sg_rules" {

      type = map(map(object({
        type        = string
        description = string
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
      })))
    }
# Lowering your AWS cloud costs

_Are your developers spending too much money on orphan cloud instances? A simple ChatOps utility built on AWS Lambda can help! This Terraform module will help prevent further shadow IT practices and replace them with a sprinkle of Infrastructure as Code._

Maybe you've experienced this before: You or your boss are shocked at how expensive your cloud services bill has become. Can you prove that all those cloud instances are being utilized with the greatest possible efficiency? Do you have a way to tag, organize and track all of your instances? If you've lost track of some instances that are no longer necessary, you're basically leaving the water running.

Many companies are dealing with this type of mess because developers and operations wanted a more agile environment to work in, but they didn't have standards or guardrails in place beforehand, and they don't have a plan to clean things up immediately either.

This write up will help you fix both of these problems with AWS-specific code that should still give you a general gameplan even if you want to use a different cloud (IE, Azure or GCP). It's based on the real-life strategies I've implemented in the past to great effect, so give it a try.


### What you'll learn

  - The top 3 methods for cutting cloud costs
  - A real example of 3 tactics used to remove unneeded instances
  - Tools for organizing and tracking your cloud resources with granularity
  [](#- What "serverless" and AWS Lambda are, and how to deploy a serverless app)
  [](#- What Terraform is)
  - How to deploy our open source ChatOps bot for cleaning up AWS instances
  - How Terraform and Sentinel can help you prevent overspending

#### Who this article is for
This article is relevant for managers and any technical roles tasked with keeping AWS instance costs under control. This may include developers, operations engineers, system administrators, cloud engineers, SREs, or solutions architects.

#### Estimated time to complete
  - 30 minutes to implement the ChatOps bot
  - 35 minutes to implement the Sentinel and Terraform workflow


### A rogue AWS account story

In large enterprises, this is a common story.

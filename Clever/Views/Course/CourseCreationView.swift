//
//  CourseCreationView.swift
//  Clever

import SwiftUI

struct CourseCreationView: View {
    @ObservedObject  var courseViewModel: CourseViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @State private var presentImporter = false
    @State private var presentFileImporter = false
    @State private var isDocumentSelected = false
    @State private var alertMessage = ""
    @State private var title = ""
    @State private var subject = ""


    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color("Purple Accent"))
                    .frame(width: 35, height: 35)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
                Image(systemName: "questionmark")
                    .foregroundColor(.gray)
                    .frame(width: 35, height: 35)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.top, 30)
            .padding(.bottom)
            .padding(.horizontal, 30)

            VStack {
                HStack(alignment: .top) {
                    Image("create-course")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 100)
                        .offset(x: 0, y: 10)
                    VStack(alignment: .leading) {
                        Text("Create New Course")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 1)

                        Text("Easily build your course \nin a few simple steps!")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding(.horizontal,30)
            .padding(.bottom, 32)

            ScrollView {
                courseDetailsSection
                UploadPDFCardView(presentImporter: $presentImporter,
                                  isDocumentSelected: $isDocumentSelected,
                                  presentFileImporter: $presentFileImporter,
                                  courseViewModel: courseViewModel)
                createCourseButton
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

extension CourseCreationView {
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }

    private var courseDetailsSection: some View {
        VStack(spacing: 15) {
            TextField("Title", text: $title)
                .font(.subheadline)
                .padding(.horizontal, 10)
                .padding(.vertical, 13)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .disableAutocorrection(true)

            TextField("Subject", text: $subject)
                .font(.subheadline)
                .padding(.horizontal, 10)
                .padding(.vertical, 13)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .disableAutocorrection(true)
        }
        .padding(.horizontal, 30)
        .padding(.top, 1)
        .padding(.bottom)
    }

    private var cancelButton: some View {
        Button("Cancel") {
            dismiss()
        }
    }

    private var createCourseButton: some View {
        Button {
            courseViewModel.createCourse(title: title, subject: subject)
            DispatchQueue.main.async {
                dismiss()
            }
        } label: {
            Text("Upload")
                .frame(maxWidth: .infinity)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding()
                .background(
                    !title.isEmpty
                    && !subject.isEmpty
                    && isDocumentSelected
                    && !courseViewModel.isCreatingFile
                    ? .luckypoint : .gray )
                .cornerRadius(10)
        }
        .padding(.top, 5)
        .padding(.horizontal, 30)
        .disabled(
            !title.isEmpty &&
            !subject.isEmpty
            && isDocumentSelected
            && !courseViewModel.isCreatingFile
            ? false : true )
    }
}

struct CourseCreationView_Previews: PreviewProvider {
    static var previews: some View {
        let courseViewModel = CourseViewModel()
        CourseCreationView(courseViewModel: courseViewModel)
    }
}

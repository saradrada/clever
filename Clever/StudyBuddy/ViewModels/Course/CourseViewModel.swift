//
//  CourseViewModel.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 27.06.23.
//

import Foundation
import _PhotosUI_SwiftUI

class CourseViewModel: NSObject, ObservableObject {
    
    private let uploadFileAPI = UploadFileService()
    private let coursesFileManager = CourseFileManager()
    private let pageFinderGenerator = PageFinderGenerator()
    private let imageSelectionViewModel = ImageSelectionViewModel()

    private let createCourseUseCase: CreateCourseUseCase
    private let askQuestionUseCase: AskQuestionUseCase
    private let getQuestionsUseCase: GetQuestionsUseCase
    private let textToSpeechUseCase: TextToSpeechUseCase
    private let getQuizAnswersUseCase: GetQuizAnswersUseCase

    private let icons: [String] = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7"
    ]
    
    @Published var courses: [Course] = []
    @Published var questions: [QuestionAnswer] = []
    @Published var pageFinderAnswers: [PageFinder] = []
    @Published var filesIds: [String] = []
    @Published var filesNames: [String] = []
    @Published var files: [File] = []

    // Quiz Answers
    @Published var questionary: [Question] = []


    @Published var isLoadingQuestions: Bool = false
    @Published var isLoadingpageFinderAnswers : Bool = false
    @Published var isCreatingFile : Bool = false
    @Published var isCreatingCourse: Bool = false
    
    // To get image URL and to create image file
    @Published var isUploadingImage: Bool = true
    @Published var isImageFileLoading: Bool = false

    // Temporal selected files when creating a course
    @Published var temporalSelectedCourses: [String] = []

    override init() {
        let questionRepository = QuestionService()

        self.createCourseUseCase = CreateCourseUseCase(repository: CourseService())
        self.askQuestionUseCase = AskQuestionUseCase(repository: questionRepository)
        self.getQuestionsUseCase = GetQuestionsUseCase(repository: questionRepository)
        self.textToSpeechUseCase = TextToSpeechUseCase(repository: SpeechService())
        self.getQuizAnswersUseCase = GetQuizAnswersUseCase(repository: QuizService())

        super.init()
        loadCourses()
    }

    func formattedQuestionText(question: Question) -> String {
        var text = "This is the question: \(question.question)\n"
        text += "And these are the options:\n"

        for (index, option) in question.options.enumerated() {
            text += "- Option \(index + 1): \(option)\n"
        }

        text += "The correct answer is: \(question.answer)\n"

        return text
    }



    func getQuizAnswers(fromImage image: PhotosPickerItem, courseId: String) {
        isImageFileLoading = true
        getURL(fromImage: image, courseId: courseId) { [weak self] url in
            self?.getQuizAnswersUseCase.execute(withImage: url, courseId: courseId){ result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let quizAnswer):
                        print("Quiz Answer: \(quizAnswer)")
                        self?.questionary = quizAnswer.questionary
                        self?.isImageFileLoading = false
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                        self?.isImageFileLoading = false
                    }
                }
            }
        }
    }

    private func getURL(fromImage image: PhotosPickerItem, courseId: String, completion: @escaping (URL) -> Void) {
        isUploadingImage = true
        DispatchQueue.global().async { [weak self] in
            self?.imageSelectionViewModel.getURL(item: image) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let url):
                        completion(url)
                        self?.isUploadingImage = false
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.isUploadingImage = false
                    }
                }
            }
        }
    }


    func handlePickedPDF(at url: URL) {
        let fileName = url.lastPathComponent
        if !filesNames.contains(fileName) {
            isCreatingFile = true
            DispatchQueue.global().async { [weak self] in
                self?.uploadFileAPI.uploadFile(pdfURL: url) { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self?.files.append(response)
                            self?.filesIds.append(response.file_id)
                            self?.filesNames.append(fileName)
                            self?.isCreatingFile = false

                        }
                    case .failure(_):
                        self?.isCreatingFile = false
                    }
                }
            }
        }
    }

    func createCourse(title: String, subject: String) {
        isCreatingCourse = true
        let course = Course(id: UUID(),
                            title: title,
                            subject: subject,
                            filesIds: self.filesIds,
                            icon: icons.randomElement()!,
                            questions: [],
                            files: self.files
        )
        createCourseUseCase.execute(course: course) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdCourse):
                    print("CREATED COURSE: \(createdCourse)")
                    print("CREATED COURSE: \(createdCourse)")
                    self?.courses.append(createdCourse)
                    self?.saveCourses()
                    self?.isCreatingCourse = false
                case .failure(let error):
                    print("Error creating course: \(error)")
                    self?.isCreatingCourse = false
                }
                self?.loadCourses()
                self?.files = []
                self?.filesNames = []

            }
        }
    }

    func saveCourses() {
        do {
            let data = try JSONEncoder().encode(courses)
            coursesFileManager.saveCourses(data: data)
        } catch {
        }
    }
    
    func loadCourses() {
        do {
            guard let data = coursesFileManager.loadCourses() else {
                return
            }
            courses = try JSONDecoder().decode([Course].self, from: data)
        } catch {
        }
    }
    
    func ask(question: String, files: [String], courseId: String) {
        isLoadingQuestions = true
        askQuestionUseCase.execute(question: question, files: files, courseId: courseId) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.questions.append(response)
                    self.getQuestions(courseId: courseId)
                    self.isLoadingQuestions = false
                }
            case .failure(let error):
                print("ERROR ERROR - \(error)")
                self.isLoadingQuestions = false
            }
        }
    }
    
    func getQuestions(courseId: String) {
//        questions = []
        isLoadingQuestions = true
            getQuestionsUseCase.execute(courseId: courseId) { result in
                DispatchQueue.main.sync {
                    switch result {
                    case .success(let questions):
                        self.questions = questions
                        self.isLoadingQuestions = false
                    case .failure(let error):
                        self.isLoadingQuestions = false
                    }
                }
            }
    }
    
    func pageFinder(indexName: String, query: String) {
//        pageFinderAnswers = []
//        isLoadingpageFinderAnswers = true
//        pageFinderGenerator.findPageFor(indexName: indexName, query: query) { result in
//            DispatchQueue.main.sync {
//                switch result {
//                case .success(let pageFinder):
//                    self.pageFinderAnswers = pageFinder
//                    self.isLoadingpageFinderAnswers = false
//                case .failure(_):
//                    self.isLoadingpageFinderAnswers = false
//                }
//            }
//        }
    }

    func getFileIds(from files: [File]) -> [String] {
        return files.map { $0.file_id }
    }
}
